class Item < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :delivery_fee_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_day_id, presence: true
  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }, numericality: { in: 300..9999999 }
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_fee_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_day_id, numericality: { other_than: 1 , message: "can't be blank"}
  #【学習備忘録】11~15li.：プルダウンid.１（＝「--」）を選んだ場合はエラー判定


  belongs_to :user #【学習備忘録】他テーブル参照：アソシエーション記述＝外部キー＋:presence true　の役割
  #READMEのuserに限ってバリデーション要らず
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_day


end
