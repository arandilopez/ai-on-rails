class DrugEmbedding < ApplicationRecord
  belongs_to :drug
  has_neighbors :embedding
end
