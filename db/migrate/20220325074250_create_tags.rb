class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :tag_name, null:false, uniqueness: true
      # タグの重複を避けるため、一意性制約かける
      t.timestamps
    end
  end
end
