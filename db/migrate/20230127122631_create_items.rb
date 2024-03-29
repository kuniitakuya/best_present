class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.integer :price, null: false
      t.string :image
      t.string :url, null: false
      t.references :wish_list, foreign_key: true

      t.timestamps
    end
  end
end
