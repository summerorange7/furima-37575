class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :town, :living_area, :building, :telephone, :user_id, :item_id, :token

  with_options presence: true do
    validates :town
    validates :living_area
    validates :telephone, format: {with: /\A[0-9]{10,11}\z/}
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
  # 【学習備忘録】テーブルのカラム（保存先）に対して行っている制限

  def save
    order = Order.create(item_id: item_id, user_id: user_id) #購入歴を管理するため = item_idとuser_idのみでよし
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, town: town, living_area: living_area, building: building, telephone: telephone, order_id: order.id)
  end
  # 【学習備忘録】↑ addressテーブルにデータ保存してくれる処理・Formオブジェクト内
  # 【学習備忘録】→ addressモデルに対してルーティング設定要らず
  # 【学習備忘録】.createは記述するカラムが保存先のカラム名と一致している必要がある
end
