class WishList < ApplicationRecord
  belongs_to :user
  has_many :items, through: :wish_list_items
  has_many :wish_list_items

  validates :list_name, presence: true, length: { maximum: 255 }
end
