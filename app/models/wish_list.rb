class WishList < ApplicationRecord
  belongs_to :user

  validates :list_name, presence: true, length: { maximum: 255 }
end
