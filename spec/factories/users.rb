FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    familyname            { '佐藤' }
    firstname             { '花子' }
    familyname_kana       { 'サトウ' }
    firstname_kana        { 'ハナコ' }
    email                 { 'test@example' }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    birthday              { '2000/1/1' }
  end
end
