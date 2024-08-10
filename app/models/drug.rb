class Drug < ApplicationRecord
  has_one :drug_embedding, dependent: :destroy
end
