class WishList < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :list_name, presence: true, length: { maximum: 255 }
end
