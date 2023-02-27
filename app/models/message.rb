class Message < ApplicationRecord
  mount_uploader :message_image, MessageImageUploader
  belongs_to :user
  belongs_to :wish_list

  validates :text, presence: true, length: { maximum: 255 }
  validates :select_item, presence: true
end
