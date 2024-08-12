class DrugSimilarity < ApplicationRecord
  belongs_to :drug
  belongs_to :similar_drug, class_name: "Drug"
end
