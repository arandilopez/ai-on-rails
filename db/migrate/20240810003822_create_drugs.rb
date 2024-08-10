class CreateDrugs < ActiveRecord::Migration[7.2]
  def change
    create_table :drugs do |t|
      t.string :name, index: true
      t.string :slug, index: true
      t.string :url
      t.text :raw_content
      t.text :content

      t.timestamps
    end
  end
end
