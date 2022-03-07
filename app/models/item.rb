class Item < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :delivery_fee_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_day_id, presence: true
  validates :price, presence: true
  
  belongs_to :user #【学習備忘録】他テーブル参照：アソシエーション記述＝外部キー＋:presence true　の役割
  #READMEのuserに限ってバリデーション要らず
  has_one_attached :image

end
