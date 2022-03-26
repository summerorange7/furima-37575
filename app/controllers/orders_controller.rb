class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :turning_point, only: :index
  before_action :order_check, only: :index

  def index
    @order_address = OrderAddress.new
    redirect_to new_card_path and return unless current_user.card.present?
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item 
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end


  private

    def set_item
      @item = Item.find(params[:item_id])
    end

    def order_params
      params.require(:order_address).permit(:postal_code, :prefecture_id, :town, :living_area, :building, :telephone).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
    end


    def turning_point
      redirect_to root_path if current_user.id == @item.user_id # 【学習備忘録】出品者かどうかの分岐 
    end

    def order_check #【学習備忘録】以下、購入履歴が存在すればトップページへ遷移
      if @item.order.present?
        redirect_to root_path
      end
    end
 
    def pay_item

      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
      customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        customer: customer_token, # 顧客のトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      # （変更前）
      # 購入処理に進むたびに入力していたところ
      # あらかじめカード情報を入れてあるので、それを呼び出せるよう変更
      # → これに伴って、ビューファイルのカード入力欄は不要になる
      # Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
      # Payjp::Charge.create(
      #   amount: @item.price,  # 商品の値段
      #   card: order_params[:token],    # カードトークン
      #   currency: 'jpy'                 # 通貨の種類（日本円）
      # )
    end
  end

