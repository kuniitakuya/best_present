class Message < ApplicationRecord
  mount_uploader :message_image, MessageImageUploader
  belongs_to :user
  belongs_to :wish_list

  def self.ransackable_attributes(_auth_object = nil)
    ["id", "text", "sender", "receiver", "created_at" ]
  end

  validates :text, presence: true, length: { maximum: 90 }
  validates :select_item, presence: true
end
