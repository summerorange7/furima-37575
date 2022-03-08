class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
  end

  def new
    @item = Item.new #【学習備忘録】newビューファイルで空箱要る為 
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path #redirect_toあり：indexアクションに移動してindexのビューファイルを表示
    else
      render :new 
      # 以下、【学習備忘録】
      #renderあり:（現在いる）createアクションの一環としてnewのビューファイルを見る
      #newのビューファイルでは:@itemにフォーム入力時に入れた情報をそのまま引き継げる
      #↑で引き継がれた情報をそのまま入れる→見た目(ビュー)的に変化なし
      # //以上、【学習備忘録】
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

end
