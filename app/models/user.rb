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
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "が正しく入力されていません" }, on: :create
  # on: :create ...createアクションにのみこの行のバリデーションが働くように指定した
  # 記述した際の追加確認事項 :新規登録ページ（=createアクション）でpasswordの欄をわざと正規表現（今回 :英数字混合）に当てはまらないよう入力
  # → ここで入力が通らなければきちんとバリデーションが働いている
  # ここでさすcreate(userコントローラー) :deviseから来ている新規登録を指す
  # resistration :新しい情報を「create」する
  # 背景 : usersコントローラーのupdateアクション（マイページの情報を更新）の際に上記バリデーションが働いて失敗していたから


  has_one :home
  has_many :items
  has_many :orders 
  has_many :sns_credentials
  has_many :comments
  has_one :card, dependent: :destroy
 
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
