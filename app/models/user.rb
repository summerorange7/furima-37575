class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :familyname, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "が正しく入力されていません" }
  validates :firstname, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "が正しく入力されていません" }
  validates :familyname_kana, presence: true, format: { with: /\A[ァ-ヶー-]+\z/, message: "が正しく入力されていません" }
  validates :firstname_kana, presence: true, format: { with: /\A[ァ-ヶー-]+\z/, message: "が正しく入力されていません" }
  # validates :email
  #参考:deviseでメールアドレスカラムを作ると、uniqueness: trueはデフォルトでついているので別途の記述は要らない
  validates :birthday, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "が正しく入力されていません" }

  has_many :items
  has_many :orders
end
