class Message < ApplicationRecord
  belongs_to :user
  belongs_to :wish_list

  validates :text, presence: true, length: { maximum: 255 }
  validates :image, presence: true
end
