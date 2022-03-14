FactoryBot.define do
  factory :order_address do
    # 【学習備忘録】アソシエーションを組めないので、それに関する記述は不要
    postal_code            { '123-4567' }
    prefecture_id          { '11' }
    town                   { 'テスト町' }
    living_area            { 'テスト1-2-3' }
    telephone              { '09012345678' }
    token                  {"tok_abcdefghijk00000000000000000"}
    end
  end