FactoryBot.define do
  factory :item do
    item_name { "test_item" }
    price { "1000" }
    url { "https://www.rakuten.co.jp/" }
    save_list { "リスト" }
    user
    wish_list
  end
end
