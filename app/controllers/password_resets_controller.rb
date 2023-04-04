class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by(email: params[:email])

    # パスワード（ランダムトークンを含むURL）をリセットする方法を説明した電子メールをユーザーに送信する
    # ぼっち演算子を使用すれば、レシーバーがnilであってもnilを返すだけ
    @user&.deliver_reset_password_instructions!

    # 電子メールが見つかったかどうかに関係なく、ユーザーの指示が送信されたことをユーザーに伝えます
    # システムに存在する電子メールに関する情報を攻撃者に漏らさないためです
    redirect_to login_path, success: t('.success')
  end

  def edit
    @token = params[:id]
    # トークンでユーザーを検索し有効期限もチェックします。 トークンが見つかり有効な場合、ユーザーを返す
    @user = User.load_from_reset_password_token(@token)
    # 有効期限切れなどでユーザーが取得できなかったとき、not_authenticatedとなる
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    # トークンでユーザーを検索し有効期限もチェックします。 トークンが見つかり有効な場合、ユーザーを返す
    @user = User.load_from_reset_password_token(@token)
    # 有効期限切れなどでユーザーが取得できなかったとき、not_authenticatedとなる
    return not_authenticated if @user.blank?

    # パスワード確認の検証を機能させます
    @user.password_confirmation = params[:user][:password_confirmation]
    # 一時トークンをクリアし、パスワードを更新します
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end
end
