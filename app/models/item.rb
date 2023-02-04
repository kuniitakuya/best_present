class Item < ApplicationRecord
  has_many :wish_lists, dependent: :destroy
end
