require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validation' do
    it '全てのカラムがある場合有効' do
      message = build(:message)
      expect(message).to be_valid
      expect(message.errors).to be_empty
    end

    it 'メッセージテキストがない場合は無効である' do
      message_without_text = build(:message, text: nil)
      expect(message_without_text).to be_invalid
      expect(message_without_text.errors[:text]).to eq [I18n.t('errors.messages.blank')]
    end

    it '選択された商品がない場合無効である' do
      message_without_select_item = build(:message, select_item: nil)
      expect(message_without_select_item).to be_invalid
      expect(message_without_select_item.errors[:select_item]).to eq [I18n.t('errors.messages.blank')]
    end
  end
end
