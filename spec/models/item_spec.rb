require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validation' do
    it '全てのカラムがある場合有効' do
      item = build(:item)
      expect(item).to be_valid
      expect(item.errors).to be_empty
    end

    it '商品名がない場合は無効である' do
      item_without_item_name = build(:item, item_name: nil)
      expect(item_without_item_name).to be_invalid
      expect(item_without_item_name.errors[:item_name]).to eq [I18n.t('errors.messages.blank')]
    end

    it 'URLがない場合無効である' do
      item_without_url = build(:item, url: nil)
      expect(item_without_url).to be_invalid
      expect(item_without_url.errors[:url]).to eq [I18n.t('errors.messages.blank')]
    end

    it '金額がない場合無効である' do
      item_without_price = build(:item, price: nil)
      expect(item_without_price).to be_invalid
      expect(item_without_price.errors[:price]).to eq [I18n.t('errors.messages.blank')]
    end

    it '保存されたリストがない場合無効である' do
      item_without_save_list = build(:item, save_list: nil)
      expect(item_without_save_list).to be_invalid
      expect(item_without_save_list.errors[:save_list]).to eq [I18n.t('errors.messages.blank')]
    end
  end
end
