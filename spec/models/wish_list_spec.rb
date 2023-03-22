require 'rails_helper'

RSpec.describe WishList, type: :model do
  describe 'validation' do
    it '全てのカラムがある場合有効' do
      wish_list = create(:wish_list)
      expect(wish_list).to be_valid
      expect(wish_list.errors).to be_empty
    end

    it 'リスト名がない場合は無効である' do
      wish_list_without_list_name = build(:wish_list, list_name: nil)
      expect(wish_list_without_list_name).to be_invalid
      expect(wish_list_without_list_name.errors[:list_name]).to eq [I18n.t('errors.messages.blank'), I18n.t('errors.messages.too_short', count: 1) ]
    end

  end
end
