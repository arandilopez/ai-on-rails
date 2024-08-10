class DrugScrapper
  attr_reader :agent

  def initialize
    @agent = Mechanize.new do |agent|
      agent.user_agent_alias = "Mac Safari"
    end
  end

  def drugs_urls(letter_range = "a".."z")
    letter_range.flat_map do |letter|
      get_drugs_urls_by_letter(letter)
    end
  end

  def drug_information(drug_url)
    get_drug_info_content(drug_url)
  end

  def get_drugs_urls_by_letter(letter)
    page = agent.get("https://www.drugs.com/alpha/#{letter}.html")
    page.search("#content > ul.ddc-list-column-2 > li > a").map do |anchor|
      url = "https://www.drugs.com#{anchor["href"]}"
      slug = url.split("/").last.split(".").first

      { name: anchor.text, slug: slug, url: url }
    end
  end

  def get_drug_info_content(drug_url)
    page = agent.get(drug_url)

    raw_content = page.search("#content").to_s

    content = page.search("#content > h2, #content > p, #content > ul, #content > b")
                  .map(&:text)
                  .join("\n")
                  .gsub(/\n... show all .*\n\n/, "")

    { content: content, raw_content: raw_content }
  end
end
