require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    # ユーザー新規登録についてのテストコードを記述

    context '新規登録できる場合' do
      it '各種カラムのデータが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        # nicknameが空では登録できないテストコードを記述
        @user.nickname = '' # あえてnicknameを空の状態にする
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end

      it 'familynameが空では登録できない' do
        # familynameが空では登録できないテストコードを記述
        @user.familyname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Familyname can't be blank"
      end

      it 'familynameに半角文字が含まれていると登録できない' do
        # familynameが空では登録できないテストコードを記述
        @user.familyname = 'ｻﾄｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Familyname is invalid'
      end

      it 'firstnameが空では登録できない' do
        # firstnameが空では登録できないテストコードを記述
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname can't be blank"
      end

      it 'firstnameに半角文字が含まれていると登録できない' do
        # firstnameが空では登録できないテストコードを記述
        @user.firstname = 'ﾊﾅｺ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname is invalid'
      end

      it 'familyname_kanaが空では登録できない' do
        # familyname_kanaが空では登録できないテストコードを記述
        @user.familyname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Familyname kana can't be blank"
      end

      it 'familyname_kanaに平仮名が含まれていると登録できない' do
        # familyname_kanaが空では登録できないテストコードを記述
        @user.familyname_kana = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Familyname kana is invalid'
      end

      it 'familyname_kanaに漢字が含まれていると登録できない' do
        # familyname_kanaが空では登録できないテストコードを記述
        @user.familyname_kana = '佐藤'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Familyname kana is invalid'
      end

      it 'familyname_kanaに英数字が含まれていると登録できない' do
        # familyname_kanaが空では登録できないテストコードを記述
        @user.familyname_kana = 'satou3'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Familyname kana is invalid'
      end

      it 'familyname_kanaに記号が含まれていると登録できない' do
        # familyname_kanaが空では登録できないテストコードを記述
        @user.familyname_kana = '*+'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Familyname kana is invalid'
      end

      it 'firstname_kanaが空では登録できない' do
        # firstname_kanaが空では登録できないテストコードを記述
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname kana can't be blank"
      end

      it 'firstname_kanaに平仮名が含まれていると登録できない' do
        # firstname_kanaが空では登録できないテストコードを記述
        @user.firstname_kana = 'はなこ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname kana is invalid'
      end

      it 'firstname_kanaに漢字が含まれていると登録できない' do
        # firstname_kanaが空では登録できないテストコードを記述
        @user.firstname_kana = '花子'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname kana is invalid'
      end

      it 'firstname_kanaに英数字が含まれていると登録できない' do
        # firstname_kanaが空では登録できないテストコードを記述
        @user.firstname_kana = 'hanako2'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname kana is invalid'
      end

      it 'firstname_kanaに記号が含まれていると登録できない' do
        # firstname_kanaが空では登録できないテストコードを記述
        @user.firstname_kana = '*+'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname kana is invalid'
      end

      it 'emailが空では登録できない' do
        # emailが空では登録できないテストコードを記述
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
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
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it 'birthdayが空では登録できない' do
        # birthdayが空では登録できないテストコードを記述
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "生年月日を入力してください"
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
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

      it 'passwordが英字のみでは登録できない' do
        # passwordが英字のみでは登録できないテストコードを記述
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end

      it 'passwordが数字のみでは登録できない' do
        # passwordが数字のみでは登録できないテストコードを記述
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end

      it 'passwordが全角文字を含んでいれば登録できない' do
        # passwordに全角文字を含んで入れば登録できないテストコードを記述
        @user.password = 'Abcdef23'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
    end
  end
end
