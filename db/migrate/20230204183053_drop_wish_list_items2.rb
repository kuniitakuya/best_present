class DropWishListItems2 < ActiveRecord::Migration[7.0]
  def change
    drop_table :wish_list_items do |t|
      t.references :wish_list, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
