namespace :drugs do
  desc "Scrap drugs"
  task :scrap_urls, [:first_letter, :second_letter] => :environment do |_, args|
    drug_scrapper = DrugScrapper.new

    letter_range = args[:first_letter]..args[:second_letter]

    drug_scrapper.drugs_urls(letter_range).each do |drug_info|
      drug = Drug.find_or_initialize_by(slug: drug_info[:slug])

      drug.update(drug_info)
    end
  end

  desc "Scrap drug content information"
  task scrap_content: :environment do
    drug_scrapper = DrugScrapper.new

    Drug.where(raw_content: nil).order(id: :asc).find_in_batches(batch_size: 100).each do |batch|
      batch.each do |drug|
        puts "Scraping #{drug.name}..."
        drug_info = drug_scrapper.drug_information(drug.url)

        drug.update(drug_info)

        puts "Done!"
      end
    end
  end

  desc "Vectorize drugs content"
  task vectorize: :environment do
    vectorizer = Vectorizer.new

    Drug.where.missing(:drug_embedding).find_each do |drug|
      puts "Vectorizing #{drug.name}..."
      embedding = vectorizer.vectorize(drug.content.squish)
      drug.drug_embedding = DrugEmbedding.new(embedding: embedding)
      drug.save!

      puts "Done!"
    end
  end
end
