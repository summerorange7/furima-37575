class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :turning_point, only: :index
  before_action :order_check, only: :index

  def index
    @order_address = OrderAddress.new
    
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
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
    end
  end

