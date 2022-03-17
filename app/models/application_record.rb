class ApplicationRecord < ActiveRecord::Base
  #継承元：ActiveRecord
  self.abstract_class = true
end

# ActiveRecordって何してる？
# 各モデルファイルからみて上位:application_record.rb
# ↑が継承している:ActiveRecord (::Base = ActiveRecordが最上位）
# 仕事：モデルに対してデータを保存させたり、取り出したりする