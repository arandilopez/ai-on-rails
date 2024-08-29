class DrugSimilarity < ApplicationRecord
  belongs_to :drug
  belongs_to :similar_drug, class_name: "Drug"

  validates_uniqueness_of :similar_drug_id, scope: :drug_id
end
