class Category < ActiveHash::Base
  self.data = [
    # 変更前  { id: 1, name: '--' }, :ransackを用いて検索機能を実装 
    # → 検索時に{ id: 1, name: '---' }を選択した場合、カテゴリーid 1で保存されているデータは無く、検索で何も引っかからなくなってしまうため
    { id: 2, name: 'レディース' },
    { id: 3, name: 'メンズ' },
    { id: 4, name: 'ベビー・キッズ' },
    { id: 5, name: 'インテリア・住まい・小物' },
    { id: 6, name: '本・音楽・ゲーム' },
    { id: 7, name: 'おもちゃ・ホビー・グッズ' },
    { id: 8, name: '家電・スマホ・カメラ' },
    { id: 9, name: 'スポーツ・レジャー' },
    { id: 10, name: 'ハンドメイド' },
    { id: 11, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :item
end
