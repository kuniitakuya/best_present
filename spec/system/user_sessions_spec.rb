require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログインに成功する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button I18n.t('defaults.login')
        expect(page).to have_content I18n.t('user_sessions.create.success')
        expect(current_path).to eq root_path
      end
    end

    context 'メールアドレスが未入力' do
      it 'ログインに失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        click_button I18n.t('defaults.login')
        expect(page).to have_content I18n.t('user_sessions.create.fail')
        expect(current_path).to eq login_path
      end
    end

    context 'パスワードが未入力' do
      it 'ログインに失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        click_button I18n.t('defaults.login')
        expect(page).to have_content I18n.t('user_sessions.create.fail')
        expect(current_path).to eq login_path
      end
    end

    context 'パスワードが異なる' do
      it 'ログインに失敗する' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'different_password'
        click_button I18n.t('defaults.login')
        expect(page).to have_content I18n.t('user_sessions.create.fail')
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウトが成功する' do
        login_as(user)
        click_button I18n.t('defaults.logout')
        expect(page).to have_content I18n.t('user_sessions.destroy.success')
        expect(current_path).to eq root_path
      end
    end
  end
end
