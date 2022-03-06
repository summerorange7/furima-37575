class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        validates :nickname, presence: true
        validates :familyname, presence: true
        validates :firstname, presence: true
        validates :familyname_kana, presence: true
        validates :firstname_kana, presence: true
        # validates :email, uniqueness: true ：参考
        validates :birthday, presence: true 
 
        # has_many :items
        # has_many :buys

        end
