require_relative 'scrapper'

module Drugs
  class Drugs
    attr_reader :scrapper

    def initialize
      @scrapper = ::Drugs::Scrapper.new
    end

    def get_drugs_info
      # ("a".."z").each do |letter|
      letter = "a"
      scrapper.get_drugs_urls_by_letter(letter).first(5).each do |drug_url|
        puts scrapper.get_drug_info(drug_url)
      end
      # end
    end
  end
end
