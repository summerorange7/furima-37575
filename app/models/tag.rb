class Tag < ApplicationRecord
  has_many :item_tag_relations
  has_many :items, through: :item_tag_relations

  validates :tag_name,  uniqueness: true
  # 一意性の制約はモデル単位で設ける必要がある
  # したがって、FormオブジェクトのItemTagFormクラスではなく、Tagモデルに記述
end
