class AddDateToWishLists < ActiveRecord::Migration[7.0]
  def change
    add_column :wish_lists, :date, :date
  end
end
