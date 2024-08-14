class DrugEmbedding < ApplicationRecord
  belongs_to :drug
  has_neighbors :embedding

  # Set the efSearch parameter for the HNSW index
  # efSearch is the number of neighbors candidates to check during the search
  def self.set_ef_search(value = 10)
    sane_value = sanitize_sql_for_assignment("hnsw.ef_search=?", value)
    connection.execute("SET #{sane_value}")
  end
end
