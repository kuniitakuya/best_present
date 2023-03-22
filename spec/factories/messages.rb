FactoryBot.define do
  factory :message do
    text { "test message" }
    sender { "test_user_1" }
    receiver { "test_user_2" }
    select_item { "test_item" }
    user
    wish_list
  end
end
