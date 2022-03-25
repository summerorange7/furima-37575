class ItemTagForm
  include ActiveModel::Model

  #ItemTagFormクラスのオブジェクトがItemモデルの属性を扱えるようにする
  attr_accessor :title, :description, :category_id, :status_id, :delivery_fee_id,
                :prefecture_id, :delivery_day_id, :price, :user_id, :images, :id, :created_at, :updated_at,
                :tag_name
               # エラー：unknown attribute 'user_id' for ItemTagForm. :attr_accessorでuser_id設定されてない
               # カラム名user_id入れば直る
               # たまにマイグレーションファイルで記述したカラム名 != コードで記述するカラム名 になることがある
               # schema.rbファイルを確認すること（db/migrate/schema.rbで入ってる）
               # schema.rbファイル :マイグレーション後実際に反映されたカラム名やデータ型を確認できる
               # schema.rbファイルのカラム名でコードを記述しよう

  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
   # presence: true #image より変更 = 画像を複数枚扱うため → コメントアウト（length使って１枚以上にすれば =presence trueと同じ意味になる）
  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :delivery_fee_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_day_id, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  validates :status_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  validates :delivery_fee_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  validates :prefecture_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  validates :delivery_day_id, numericality: { other_than: 1, message: "は必ずどれか選んで下さい" }
  # 【学習備忘録】11~15li.：プルダウンid.１（＝「--」）を選んだ場合はエラー判定
           
    def save
      item = Item.create(title: title, description: description, category_id: category_id, status_id: status_id, delivery_fee_id: delivery_fee_id, prefecture_id: prefecture_id,
                  delivery_day_id: delivery_day_id, price: price, images: images, user_id: user_id )
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save
      ItemTagRelation.create(item_id: item.id, tag_id: tag.id) # tagとitemの紐付けの情報を、中間テーブルに保存
                  # 変更前↓
                  #  Item.create(title: title, description: description, category_id: category_id, status_id: status_id, delivery_fee_id: delivery_fee_id, prefecture_id: prefecture_id,
                  #   delivery_day_id: delivery_day_id, price: price, images: images, user_id: user_id )
    end

  def update(params, item) 
    # Formオブジェクトに対して更新かけるための記述
    # コントローラーではupdateアクションにValid?メソッドと共にここのupdateを記述
    
    #一度タグの紐付けを消す
    item.item_tag_relations.destroy_all

    #paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
    tag_name = params.delete(:tag_name)

    # deleteメソッド :配列から対象のデータだけ抜き取る → 抜き取ったデータが返り値となって戻る
    # ①まずは配列の状態を確認
    # fruits = ["apple", "orange", "banana", "kiwi","banana"] | ["apple", "orange", "banana", "kiwi", "banana"]
    # ②変数fruitに、配列fruitsにdeleteメソッドをかけた状態のものを代入 → bananaだけ出てくる
    # fruit = fruits.delete("banana")                         | "banana"
    # ③変数fruitにはbananaが入っている
    # fruit                                                   | "banana"
    # ④deleteメソッドをかけられた後の配列fruitsはbanana以外が残った状態になっている
    # fruits                                                  | ["apple", "orange", "kiwi"]

    #もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present? 
    # tag_name: tag_nameのうち右のtag_name、tag_name.present?のtag_nameは上で記述した変数tag_name

    #タグを保存
    tag.save if tag_name.present? 
    item.update(params)
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present? 
  end

    # item.update(params)（変更前）
end