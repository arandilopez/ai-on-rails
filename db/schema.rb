# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_11_172108) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "drug_embeddings", force: :cascade do |t|
    t.bigint "drug_id", null: false
    t.vector "embedding", limit: 1024, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drug_id"], name: "index_drug_embeddings_on_drug_id"
    t.index ["embedding"], name: "index_drug_embeddings_on_embedding", opclass: :vector_cosine_ops, using: :hnsw
  end

  create_table "drug_similarities", force: :cascade do |t|
    t.bigint "drug_id", null: false
    t.bigint "similar_drug_id", null: false
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drug_id", "similar_drug_id"], name: "index_drug_similarities_on_drug_id_and_similar_drug_id", unique: true
    t.index ["drug_id"], name: "index_drug_similarities_on_drug_id"
    t.index ["similar_drug_id"], name: "index_drug_similarities_on_similar_drug_id"
  end

  create_table "drugs", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "url"
    t.text "raw_content"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_drugs_on_name"
    t.index ["slug"], name: "index_drugs_on_slug"
  end

  add_foreign_key "drug_embeddings", "drugs"
  add_foreign_key "drug_similarities", "drugs"
  add_foreign_key "drug_similarities", "drugs", column: "similar_drug_id"
end
