class AddReferencesToWishLists < ActiveRecord::Migration[7.0]
  def change
    add_reference :wish_lists, :item, foreign_key: true
  end
end
