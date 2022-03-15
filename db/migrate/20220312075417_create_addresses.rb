class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :town, null: false
      t.string :living_area, null: false
      t.string :telephone, null: false
      t.string :building
      t.references :order, null: false, foreign_key: true
      t.timestamps
    end
  end
end
