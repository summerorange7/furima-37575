require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    # ユーザー新規登録についてのテストコードを記述します
    it 'nicknameが空では登録できない' do
      # nicknameが空では登録できないテストコードを記述
      @user.nickname = '' #あえてnicknameを空の状態にする
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end

    it 'familynameが空では登録できない' do
      # familynameが空では登録できないテストコードを記述
      @user.familyname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Familyname can't be blank"
    end 
   
    it 'firstnameが空では登録できない' do
      # firstnameが空では登録できないテストコードを記述
      @user.firstname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Firstname can't be blank"
    end

    it 'familyname_kanaが空では登録できない' do
      # familyname_kanaが空では登録できないテストコードを記述
      @user.familyname_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Familyname kana can't be blank"
    end

    it 'firstname_kanaが空では登録できない' do
      # firstname_kanaが空では登録できないテストコードを記述
      @user.firstname_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Firstname kana can't be blank"
    end

    it 'emailが空では登録できない' do
      # emailが空では登録できないテストコードを記述
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'passwordが空では登録できない' do
      # passwordが空では登録できないテストコードを記述
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'passwordとpassword_confirmationが一致していないと登録できない' do
      # passwordとpassword_confirmationが一致していないと登録できないテストコードを記述
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'birthdayが空では登録できない' do
      # birthdayが空では登録できないテストコードを記述
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birthday can't be blank"
    end

    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが5文字以下では登録できない' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

  end
end
