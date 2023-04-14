class Item < ApplicationRecord
  belongs_to :wish_list
  belongs_to :user

  validates :item_name, presence: true
  validates :price, presence: true
  validates :url, presence: true
  validates :save_list, presence: true
  validate :validate_keyword, on: :search

  private

  def validate_keyword
    return if keyword.blank?

    if keyword.length > 128
      errors.add(:keyword, 'は半角128文字以内で入力してください')
    end

    keyword.split.each do |word|
      if word.length == 1 && word !~ /\p{Hiragana}|\p{Katakana}|[[:punct:]]/
        errors.add(:keyword, '各検索キーワードは半角2文字 もしくは 全角1文字 以上で指定してください')
      elsif word =~ /\p{Hiragana}|\p{Katakana}|[[:punct:]]/ && word.length < 2
        errors.add(:keyword, 'ひらがな・カタカナ・記号を含む検索キーワードは2文字以上で指定してください')
      end
    end
  end
end
