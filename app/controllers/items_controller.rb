class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :turning_point, only: [:edit, :destroy]
  before_action :order_check, only: :edit

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new # 【学習備忘録】newビューファイルで空箱要る為
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path # redirect_toあり：indexアクションに移動してindexのビューファイルを表示
    else
      render :new
      # 以下、【学習備忘録】
      # renderあり:（現在いる）createアクションの一環としてnewのビューファイルを見る
      # newのビューファイルでは:@itemにフォーム入力時に入れた情報をそのまま引き継げる
      # ↑で引き継がれた情報をそのまま入れる→見た目(ビュー)的に変化なし
      # //以上、【学習備忘録】
    end
  end

  def show
    # 【学習備忘録】itemsテーブルよりparamsに入ったidに該当するレコードを引っ張り出して入れておく
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def edit # 【学習備忘録】商品の編集

  end

  def update
    if @item.update(item_params) # 【学習備忘録】item_params:formで入力した内容を一式更新するため
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy # 【学習備忘録】商品詳細の削除
    @item.destroy # ログイン中 = 出品者であればここから動く
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :delivery_day_id, :price, {images: []}).merge(user_id: current_user.id)
      #{images: []} = 画像を複数枚投稿できるようparams内も変更
      #images:[]の記述はpermitの中でも必ず最後に行うこと = 最後以外の記述はエラーの原因
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def turning_point
    redirect_to action: :index unless current_user.id == @item.user_id # 【学習備忘録】出品者かどうかの分岐
  end
  
  def order_check #【学習備忘録】以下、購入履歴が存在すればトップページへ遷移
    if @item.order.present?
      redirect_to root_path
    end
  end

end
