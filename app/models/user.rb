class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

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
  has_many :sns_credentials
  has_many :comments
 
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
     nickname: auth.info.name,
       email: auth.info.email
   )
      if user.persisted?
        sns.user = user
        sns.save
      end
      { user: user, sns: sns }
  end
end
