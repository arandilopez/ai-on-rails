class Drug < ApplicationRecord
  SEARCH_LIMIT = 20

  has_one :drug_embedding, dependent: :destroy
  has_many :drug_similarities, -> { order(rank: :asc) }, dependent: :destroy
  has_many :similar_drugs, through: :drug_similarities

  # Nearest neighbors search
  def self.search(query, limit = SEARCH_LIMIT)
    vector = Vectorizer.new.vectorize_query(query)
    DrugEmbedding.set_ef_search(limit * 1.2)
    Drug.where(id: DrugEmbedding.select(:drug_id).nearest_neighbors(:embedding, vector,
                                                                    distance: "cosine").first(limit))
  end

  def similars(limit = SEARCH_LIMIT)
    # Returns similar drugs from cache
    similars = similar_drugs.limit(limit)
    return similars if similars.length <= limit

    # If there are not enough similar drugs find the most similar drugs using nearest neighbors search
    # and store them in the database
    DrugEmbedding.set_ef_search(limit * 1.5)
    drug_ids = DrugEmbedding.nearest_neighbors(:embedding, drug_embedding.embedding, distance: "cosine")
                            .where.not(drug_id: id).limit(limit).pluck(:drug_id)
    drug_ids.each_with_index do |drug_id, index|
      DrugSimilarity.upsert({ drug_id: id, similar_drug_id: drug_id, rank: index + 1 })
    end

    Drug.where(id: drug_ids)
  end

  def to_param
    slug
  end
end
