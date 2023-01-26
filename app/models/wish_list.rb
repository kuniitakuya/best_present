class WishList < ApplicationRecord
  belongs_to :User

  validates :list_name, presence: true, length: { maximum: 255 }
end
