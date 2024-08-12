class DrugEmbedding < ApplicationRecord
  belongs_to :drug
  has_neighbors :embedding

  def self.set_ef_search(value = 10)
    sane_value = sanitize_sql_for_assignment("hnsw.ef_search=?", value)
    connection.execute("SET #{sane_value}")
  end
end
