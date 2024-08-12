class CreateDrugSimilarities < ActiveRecord::Migration[7.2]
  def change
    create_table :drug_similarities do |t|
      t.references :drug, null: false, foreign_key: true
      t.references :similar_drug, null: false, foreign_key: { to_table: :drugs }
      t.integer :rank, null: false
      t.timestamps

      t.index %i[drug_id similar_drug_id], unique: true
    end
  end
end
