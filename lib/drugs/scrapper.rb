module Drugs
  class Scrapper
    attr_reader :agent

    def initialize
      @agent = Mechanize.new do |agent|
        agent.user_agent_alias = "Mac Safari"
      end
    end

    def get_drugs_urls_by_letter(letter)
      page = agent.get("https://www.drugs.com/alpha/#{letter}.html")
      page.search("#content > ul.ddc-list-column-2 > li > a").map do |anchor|
        anchor["href"]
      end
    end

    def get_drug_info(drug_url)
      page = agent.get("https://www.drugs.com#{drug_url}")

      slug = drug_url.split("/").last.split(".").first
      name = page.search(".ddc-pronounce-title h1").text
      content = page.search("#content > h2, #content > p, #content > ul, #content > b").map(&:text).join("\n").gsub(
        /\n... show all .*\n\n/, ""
      )

      { slug: slug, name: name, content: content }
    end
  end
end
