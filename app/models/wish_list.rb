class WishList < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :messages, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "id", "list_name", "updated_at", "user_id"]
  end

  validates :list_name, presence: true, length: { in: 1..75 }
end
