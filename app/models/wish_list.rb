class WishList < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :list_name, presence: true, length: { maximum: 255 }
end
