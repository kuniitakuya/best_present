require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it '全てのカラムがある場合有効' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it '名前がない場合は無効である' do
      user_without_name = build(:user, name: nil)
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq [I18n.t('errors.messages.blank')]
    end

    it 'メールアドレスがない場合無効である' do
      user_without_email = build(:user, email: nil)
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to eq [I18n.t('errors.messages.blank')]
    end

    it 'パスワードが3文字以上ない場合無効である' do
      user_without_password = build(:user, password: nil)
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors[:password]).to eq [I18n.t('errors.messages.too_short', count: 3)]
    end

    it 'パスワードの確認がない場合無効である' do
      user_without_password_confirmation = build(:user, password_confirmation: nil)
      expect(user_without_password_confirmation).to be_invalid
      expect(user_without_password_confirmation.errors[:password_confirmation]).to eq [I18n.t('errors.messages.blank')]
    end

    it 'パスワードとパスワードの確認が異なる' do
      user = create(:user)
      user_without_password_confirmation = build(:user, password: user.password, password_confirmation: "password_confirmation")
      expect(user_without_password_confirmation).to be_invalid
      expect(user_without_password_confirmation.errors[:password_confirmation]).to eq [I18n.t('errors.messages.confirmation', attribute: User.human_attribute_name(:password))]
    end

    it '同じメールアドレスがある場合無効である' do
      user = create(:user)
      user_with_duplicated_email = build(:user, email: user.email)
      expect(user_with_duplicated_email).to be_invalid
      expect(user_with_duplicated_email.errors[:email]).to eq [I18n.t('errors.messages.taken')]
    end

    it '同じメールアドレスがない場合有効である' do
      user_with_another_email = build(:user, email: 'example@example.com')
      expect(user_with_another_email).to be_valid
      expect(user_with_another_email.errors).to be_empty
    end
  end
end
