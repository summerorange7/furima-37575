require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    # factorybotで出品データ作る
  end

  describe '商品出品登録' do
    # 商品出品登録についてのテストコードを記述
    context '出品登録できる場合' do
      it '各種カラムのデータが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品登録できない場合' do
      it 'ユーザーが紐づいていなければ登録できない' do
        # userが紐づいていなければ登録できないテストコードを記述
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'ユーザーを入力してください'
      end

      it '画像が空では登録できない' do
        # imageが空では登録できないテストコードを記述
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "商品画像は1枚以上5枚以下にしてください"
      end

      it '商品名が空では登録できない' do
        # titleが空では登録できないテストコードを記述
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end

      it '商品説明が空では登録できない' do
        # descriptionが空では登録できないテストコードを記述
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の説明を入力してください"
      end

      it 'カテゴリーが未登録では登録できない' do
        # category_idが1では登録できないテストコードを記述
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーは必ずどれか選んで下さい"
      end

      it '商品の状態が未登録では登録できない' do
        # category_idが1では登録できないテストコードを記述
        @item.status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態は必ずどれか選んで下さい"
      end

      it '配送料の負担が未登録では登録できない' do
        # delivery_fee_idが1では登録できないテストコードを記述
        @item.delivery_fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担は必ずどれか選んで下さい"
      end

      it '発送元の地域が未登録では登録できない' do
        # prefecture_idが1では登録できないテストコードを記述
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域は必ずどれか選んで下さい"
      end

      it '発送までの日数が未登録では登録できない' do
        # delivery_day_idが1では登録できないテストコードを記述
        @item.delivery_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数は必ずどれか選んで下さい"
      end

      it '販売価格が空では登録できない' do
        # priceが空では登録できないテストコードを記述
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格を入力してください"
      end

      it '販売価格がアルファベットでは登録できない' do
        # priceがアルファベットでは登録できないテストコードを記述
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売価格は数値で入力してください'
      end

      it '販売価格がひらがなでは登録できない' do
        # priceがひらがなでは登録できないテストコードを記述
        @item.price = 'あいう'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売価格は数値で入力してください'
      end

      it '販売価格がカタカナでは登録できない' do
        # priceがカタカナでは登録できないテストコードを記述
        @item.price = 'アイウ'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売価格は数値で入力してください'
      end

      it '販売価格が漢字では登録できない' do
        # priceがカタカナでは登録できないテストコードを記述
        @item.price = '愛'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売価格は数値で入力してください'
      end

      it '販売価格が全角数字では登録できない' do
        # priceがカタカナでは登録できないテストコードを記述
        @item.price = '１２３'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売価格は数値で入力してください'
      end

      it '販売価格が299円以下では登録できない' do
        # priceが299円では登録できないテストコードを記述
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売価格は300以上の値にしてください'
      end

      it '販売価格が10000000円以上では登録できない' do
        # priceが10000000円では登録できないテストコードを記述
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売価格は9999999以下の値にしてください'
      end
    end
  end
end
