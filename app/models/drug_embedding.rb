class DrugEmbedding < ApplicationRecord
  belongs_to :drug
  has_neighbors :embedding

  # Set the efSearch parameter for the HNSW index
  # efSearch is the number of neighbors candidates to check during the search
  def self.set_ef_search(value = 10)
    connection.execute(sanitize_sql_array(["SET hnsw.ef_search = ?;", value.to_i]))
  end
end
