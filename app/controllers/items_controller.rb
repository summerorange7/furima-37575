class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :turning_point, only: [:edit, :destroy]
  before_action :order_check, only: :edit

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item_tag_form = ItemTagForm.new
    # 【変更前】@item = Item.new # 【学習備忘録】newビューファイルで空箱要る為
  end

  def create
      @item_tag_form = ItemTagForm.new(item_tag_form_params)
      if @item_tag_form.valid?
        @item_tag_form.save  
    # 以下、変更前
      # @item = Item.new(item_params)
      # if @item.save
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
     # @itemから情報をハッシュとして取り出し、@item_tag_formとしてインスタンス生成する
     item_attributes = @item.attributes
     @item_tag_form = ItemTagForm.new(item_attributes)
     @item_tag_form.tag_name = @item.tags&.first&.tag_name # もしtagがあればあらかじめ編集画面の入力フォームにタグ名が表示されるように実装
  end

  def update 
    @item_tag_form = ItemTagForm.new(item_tag_form_params) #paramsの内容を反映したインスタンスを生成
      
    @item_tag_form.images ||= @item.images.blobs # 画像を選択し直していない場合は、既存の画像をセットする
    # ||= :自己代入演算子...左辺がnilの場合に右辺を代入
    # blob :画像を入れる変数が複数形(images)なので、blobも複数形（blobs）に変更

    if @item_tag_form.valid? # FormオブジェクトではApplicationRecordを継承してない為、バリデーションを勝手にかけてくれることがなくなっているから
        @item_tag_form.update(item_tag_form_params, @item)  #.updateはFormオブジェクトのクラスで設定したメソッド
        # 変更前
        # if @item.update(item_params) # 【学習備忘録】item_params:formで入力した内容を一式更新するため
      redirect_to item_path(@item) # @item :商品の情報を見られれば良いので、params設定は不要
                                    # Formオブジェクト用のparams（ここではitem_tag...）で指定しなくてよし
    else
      render :edit
    end
  end
  # formオブジェクトに対するupdateアクション
  # resourcesでルーティングを生成したときのupdateでは動かない（=Formオブジェクトには実在モデルがないから）
  # →別途Formオブジェクトとして使っているクラスにupdateアクションを記述する
  # 使用するモデル:Formオブジェクトに入れ込んでいる実在のモデル（ここではItemモデル）

  def destroy # 【学習備忘録】商品詳細の削除
    @item.destroy # ログイン中 = 出品者であればここから動く
    redirect_to root_path
  end

  def search #インクリメンタルサーチ（逐次検索機能）の実装のため新たに記述
    return nil if params[:keyword] == "" # フォームの入力内容が空だったらjsファイルに対してnilを返す
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def item_tag_form_params #ストロングパラメーター
    params.require(:item_tag_form).permit(:title, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :delivery_day_id, :price, :tag_name, {images: []} ).merge(user_id: current_user.id)
      
      # {images: []} = 画像を複数枚投稿できるようparams内も変更
      # images:[]の記述はpermitの中でも必ず最後に行うこと = 最後以外の記述はエラーの原因
      # permitの中で記述している名前 != モデルのカラム名
      # params.require(A).permit(B,C...) = ビューから送られたparamsの中のハッシュ「A」の中のキーである「BやC...」の値を指定し開封して取り出す
  
      # paramsとストロングパラメーターの違い確認！
      # params :ビューから送られるデータの梱包方式（=送る側）
      # ストロングパラメーター :コントローラーで決める、「paramsから何を取り出すか」（=受け取る側）
      
      # binding.pryを仕掛ける場所 :エラーが出る直前
      # ex. 保存しようとしたらエラー出た　→ createアクションの一番上(保存行動が起きる直前)

    end

  # 変更前 :Formオブジェクト内でitemモデル単独のparamsを使うことがないのでコメントアウト
  # def item_params
  #   params.require(:item).permit(:title, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
  #                                :delivery_day_id, :price, {images: []} ).merge(user_id: current_user.id)
  #     #{images: []} = 画像を複数枚投稿できるようparams内も変更
  #     #images:[]の記述はpermitの中でも必ず最後に行うこと = 最後以外の記述はエラーの原因
  # end

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
# params :フォームから入力された情報が送られる時に梱包されるときの決まった状態
# paramsで指定しないと影響あるアクション :new,create,updateでの保存作業時
# new:新たにデータを保存したいときにparamsのカラムを一致させる必要ある
# create:フォームから送られた情報をモデルに保存
# update:フォームから送られた情報をモデルに更新して保存
# それ以外のアクション（showとかdestroy）やページ遷移はそもそもフォームから送られることがない
# なんなら、データを取り出すのは既に保存された後のモデルから
# showとかdestroyとかはFormオブジェクトに関わる変数でなく、元々あるモデルの変数で良い
# 今回：redirect_toは@itemの指定で良いし、destroyアクションも変数は@itemの指定で良い