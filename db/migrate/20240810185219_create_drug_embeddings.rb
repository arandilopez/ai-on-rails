class CreateDrugEmbeddings < ActiveRecord::Migration[7.2]
  def change
    create_table :drug_embeddings do |t|
      t.references :drug, null: false, foreign_key: true
      t.vector :embedding, null: false, limit: 1024

      t.timestamps

      # Create a HNSW index on the embedding column for cosine similarity search
      t.index :embedding, using: :hnsw, opclass: :vector_cosine_ops
    end
  end
end
