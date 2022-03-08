require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    #factorybotで出品データ作る
  end  

  describe '商品出品登録' do
    # 商品出品登録についてのテストコードを記述
    context '出品登録できる場合' do
      it '各種カラムのデータが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品登録できない場合' do
      it 'ユーザーが空では登録できない' do
        # userが空では登録できないテストコードを記述
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end


      it '商品名が空では登録できない' do
        # titleが空では登録できないテストコードを記述
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Title can't be blank"
      end

      it '商品説明が空では登録できない' do
        # descriptionが空では登録できないテストコードを記述
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end

      it 'カテゴリーが未登録では登録できない' do
        # category_idが1では登録できないテストコードを記述
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it '商品の状態が未登録では登録できない' do
        # category_idが1では登録できないテストコードを記述
        @item.status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Status can't be blank"
      end

      it '配送料の負担が未登録では登録できない' do
        # delivery_fee_idが1では登録できないテストコードを記述
        @item.delivery_fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery fee can't be blank"
      end

      it '発送元の地域が未登録では登録できない' do
        # prefecture_idが1では登録できないテストコードを記述
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end

      it '発送までの日数が未登録では登録できない' do
        # delivery_day_idが1では登録できないテストコードを記述
        @item.delivery_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery day can't be blank"
      end

      it '販売価格が空では登録できない' do
        # priceが空では登録できないテストコードを記述
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end

      it '販売価格が299円以下では登録できない' do
        # priceが299円では登録できないテストコードを記述
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end

      it '販売価格が10000000円以上では登録できない' do
        # priceが10000000円では登録できないテストコードを記述
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
      end

    end

  end
end
