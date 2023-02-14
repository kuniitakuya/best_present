class WishList < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "list_name", "updated_at", "user_id"]
  end

  validates :list_name, presence: true, length: { maximum: 255 }
end
