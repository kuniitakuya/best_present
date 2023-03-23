require 'rails_helper'

RSpec.describe "WishLists", type: :system do
  let(:user) { create(:user) }
  let(:wish_list) { create(:wish_list) }

  before { login_as(user) }
  describe '欲しいものリスト作成' do
    context 'リスト名の入力値が正常' do
      it '欲しいものリスト作成が成功する' do
        login_as(user)
        with_list = build(:wish_list)
        visit new_wish_list_path
        fill_in "wish_list[list_name]", with: wish_list.list_name
        click_button I18n.t('defaults.list.create')
        expect(page).to have_content I18n.t('defaults.message.created', item: WishList.model_name.human)
      end
    end

    context 'リスト名が未入力' do
      it '欲しいものリスト作成が失敗する' do
        login_as(user)
        visit new_wish_list_path
        fill_in "wish_list[list_name]", with: ''
        click_button I18n.t('defaults.list.create')
        expect(page).to have_content I18n.t('defaults.message.not_created', item: WishList.model_name.human)
        expect(page).to have_content WishList.human_attribute_name(:list_name) + I18n.t('errors.messages.required')
        expect(page).to have_content WishList.human_attribute_name(:list_name) + I18n.t('errors.messages.too_short', count: 1)
        expect(current_path).to eq new_wish_list_path
      end
    end
  end
end
