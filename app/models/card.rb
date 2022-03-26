class Card < ApplicationRecord
  belongs_to :user

  # createアクションに対してバリデーションが必要（ :正しくカードの情報が送られなかった時にエラーになる）
  # カードの情報が正しくないときは、card_tokenそのものがコントローラー側に送られない
  # そこで、card_tokenに対するバリデーションを設定し、保存段階で条件分岐をするように記述。
  # なお、card_tokenを保存するカラムはcardsテーブルに存在しないため、
  # バリデーションを設定するためにはattr_accessorでキーを指定する必要がある
  attr_accessor :card_token
  validates :card_token, presence: true
end
