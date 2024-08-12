namespace :drugs do
  desc "Scrap drugs"
  task :scrap_urls, [:first_letter, :second_letter] => :environment do |_, args|
    drug_scrapper = DrugScrapper.new

    letter_range = args[:first_letter]..args[:second_letter]

    puts "Scraping drugs from #{letter_range}..."

    drug_scrapper.drugs_urls(letter_range).each do |drug_info|
      drug = Drug.find_or_initialize_by(slug: drug_info[:slug])

      drug.update(drug_info)
    end

    puts "Done!"
  end

  desc "Scrap drug content information"
  task scrap_content: :environment do
    drug_scrapper = DrugScrapper.new

    Drug.where(raw_content: nil).order(id: :asc).find_in_batches(batch_size: 100).each do |batch|
      batch.each do |drug|
        puts "Scraping #{drug.name} information..."
        drug_info = drug_scrapper.drug_information(drug.url)
        drug.raw_content = drug_info[:content]
        drug.save!

        puts "Done!"
      end
    end
  end

  desc "Convert drugs content to markdown"
  task :convert_to_markdown, [:limit] => :environment do |_, args|
    args.with_defaults(limit: nil)
    drug_ai = DrugAi.new

    Drug.where(content: nil).limit(args[:limit]).find_in_batches(batch_size: 100) do |batch|
      batch.each do |drug|
        puts "Converting #{drug.name} to markdown..."
        drug.content = drug_ai.format_to_markdown(drug)
        drug.save!

        puts "Done!"
      end
    end
  end

  desc "Vectorize drugs content"
  task vectorize: :environment do
    vectorizer = Vectorizer.new

    Drug.where.missing(:drug_embedding).find_each do |drug|
      puts "Vectorizing #{drug.name}..."
      embedding = vectorizer.vectorize(drug.raw_content)
      drug.drug_embedding = DrugEmbedding.new(embedding: embedding)
      drug.save!

      puts "Done!"
    end
  end
end
