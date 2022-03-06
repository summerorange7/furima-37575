FactoryBot.define do
  factory :user do
    nickname              {'test'}
    familyname            {'test2'}
    firstname             {'test3'}
    familyname_kana       {'test4'}
    firstname_kana        {'test5'}
    email                 {'test@example'}
    password              {'000000'}
    password_confirmation {password}
    birthday              {'2000/1/1'}
  end
end