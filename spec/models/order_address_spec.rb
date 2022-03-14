require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user.id) # [学習備忘録]Formの外部参照キーはassociationメソッド使用不可の為
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入登録' do
      context '内容に問題ない場合' do
        it 'すべての値が正しく入力されていれば保存できること' do
          expect(@order_address).to be_valid
        end
        it 'buildingは空でも保存できること' do
            #建物名は空でも登録できる
            @order_address.building = ''
            expect(@order_address).to be_valid
        end
      end

    context '内容に問題がある場合' do
        it 'postal_codeが空だと保存できないこと' do
          #郵便番号が空では登録できない
          @order_address.postal_code = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "Postal code can't be blank"
        end
        it 'postal_codeが半角でないと保存できないこと' do
        #郵便番号が半角数字でないと登録できない
          @order_address.postal_code = '１２３４５６７'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
        end
        it 'postal_codeがハイフンを含んでないと保存できないこと' do
          #郵便番号にハイフンがないと登録できない
            @order_address.postal_code = '1234567'
            @order_address.valid?
            expect(@order_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
          end

        it 'prefectureを選択していないと保存できないこと' do
          #都道府県を選択していないと登録できない
          @order_address.prefecture_id = '1'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "Prefecture can't be blank"
        end
        it 'townが空だと保存できないこと' do
            #市区町村が空では登録できない
          @order_address.town = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "Town can't be blank"
        end
        it 'living_areaが空だと保存できないこと' do
          #番地が空では登録できない
          @order_address.living_area = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "Living area can't be blank"
          end
        it 'telephoneが空だと保存できないこと' do
          #電話番号が空では登録できない
          @order_address.telephone = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "Telephone can't be blank"
        end
        it 'telephoneにハイフンが含まれていると保存できないこと' do
          #電話番号にハイフンがあると登録できない
          @order_address.telephone = '090-1234567'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "Telephone is invalid"
        end
        it 'userが紐付いていないと保存できないこと' do
          #user_idが空では登録できない
          #【学習備忘録】associationメソッド使えない為、orderテーブル内user_idに値あるかどうかでテスト
          @order_address.user_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "User can't be blank"
        end
        it 'itemが紐付いていないと保存できないこと' do
          #item_idが空では登録できない
          @order_address.item_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include "Item can't be blank"
        end
        it "tokenが空では登録できないこと" do
          @order_address.token = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Token can't be blank")
        end
      end
  end
end