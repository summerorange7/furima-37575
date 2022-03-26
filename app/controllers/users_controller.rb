class UsersController < ApplicationController
 # このコントローラーはコマンドで作成 = rails g controller users show
 # showの記述 :showアクションのビューページだけ必要だから
  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    card = Card.find_by(user_id: current_user.id) # ユーザーのid情報を元に、カード情報を取得
    # 「user_id: current_user.id」は、あくまでログインしているユーザーのid情報であって、
    # カード登録した顧客情報とは異なる

    redirect_to new_card_path and return unless card.present? #カード情報が入ってない限りはカード登録ページへ移動
   
    customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
  end

  def update
    if current_user.update(user_params) # 更新出来たかを条件分岐する
      redirect_to root_path # 更新できたらrootパスへ
    else
      redirect_to action: "show" # 失敗すれば再度マイページへ
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email) # 編集出来る情報を制限
  end
end
