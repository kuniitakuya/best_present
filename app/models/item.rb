class Item < ApplicationRecord
  belongs_to :wish_list
  belongs_to :user

  validates :item_name, presence: true
  validates :price, presence: true
  validates :url, presence: true
  validates :save_list, presence: true
end
