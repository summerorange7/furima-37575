# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new #ウィザード形式新規登録機能実装のため、新規登録への遷移をこちらに記述
    @user = User.new
  end

  def new_home #ウィザード形式新規登録機能実装のため、新規登録ページのフォーム内容（第一段階）を保存して住所登録へ遷移する処理
    @user = User.new(sign_up_params)
     unless @user.valid? # 1ページ目で入力した情報のバリデーションチェックをすること
       render :new and return
       # なぜ returnある？ :renderが二回実行されることを防ぐため
        #  renderが2回実行された場合、DoubleRenderErrorというエラーが発生
        # andは2つの処理を1行で済ませるために記述しているもの = 改行すればandは不要
     end
    session["devise.regist_data"] = {user: @user.attributes}# 1ページ目で入力した情報をsessionに保持させること
    # attributesメソッド :オブジェクト型からハッシュ型に変換できるメソッド、キーとバリューで値をもらえる
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @home = @user.build_home  # 次の住所情報登録で使用するインスタンスを生成し
    render :new_home # 該当ページへ遷移すること
  end

  def create_home # 住所登録処理
    @user = User.new(session["devise.regist_data"]["user"])
    @home = Home.new(home_params)
     unless @home.valid?
       render :new_home and return
     end
    @user.build_home(@home.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end
 
  private
 
  def home_params
    params.require(:home).permit(:postal_code, :address)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
      if params[:sns_auth] == 'true'
        pass = Devise.friendly_token
        params[:user][:password] = pass
        params[:user][:password_confirmation] = pass
      end
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
