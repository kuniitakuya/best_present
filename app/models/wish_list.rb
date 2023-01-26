class WishList < ApplicationRecord
  belongs_to :User

  validates :name, presence: true, length: { maximum: 255 }
end
