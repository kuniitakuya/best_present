class RemoveWishListIdFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :items, :wish_lists
    remove_reference :items, :wish_list, index: true
  end
end
