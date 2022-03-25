class Item < ApplicationRecord
  # validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
  # # presence: true #image より変更 = 画像を複数枚扱うため → コメントアウト（length使って１枚以上にすれば =presence trueと同じ意味になる）
  # validates :title, presence: true
  # validates :description, presence: true
  # validates :category_id, presence: true
  # validates :status_id, presence: true
  # validates :delivery_fee_id, presence: true
  # validates :prefecture_id, presence: true
  # validates :delivery_day_id, presence: true
  # validates :price, presence: true
  # validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  # validates :category_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  # validates :status_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  # validates :delivery_fee_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  # validates :prefecture_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  # validates :delivery_day_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  # # 【学習備忘録】11~15li.：プルダウンid.１（＝「--」）を選んだ場合はエラー判定
  #【学習備忘録】バリデーションのみItemTagFormクラスへ移動したためコメントアウト

  belongs_to :user # 【学習備忘録】他テーブル参照：アソシエーション記述＝外部キー＋:presence true　の役割
  # 【学習備忘録】READMEのuserに限ってバリデーション要らず
  has_one :order
  has_many_attached :images # has_one_attached :image より変更＝画像を複数枚扱うため
  has_many :comments
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations # 中間テーブルを介して

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_day
end
