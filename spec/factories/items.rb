FactoryBot.define do
  factory :item do
    # 【学習備忘録】アソシエーションを組んでいるモデルは下記記述要
    association :user
    title                  { '鉢植え' }
    description            { '数種類の植物を植えてあります' }
    category_id            { '2' }
    status_id              { '3' }
    delivery_fee_id        { '2' }
    prefecture_id          { '10' }
    delivery_day_id        { '2' }
    price                  { '1000' }

    after(:build) do |item|
      item.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
