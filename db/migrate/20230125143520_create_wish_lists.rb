class CreateWishLists < ActiveRecord::Migration[7.0]
  def change
    create_table :wish_lists do |t|
      t.string :list_name, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
