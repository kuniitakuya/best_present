class Item < ApplicationRecord
  has_many :wish_lists, through: :wish_list_items
  has_many :wish_list_items
end
