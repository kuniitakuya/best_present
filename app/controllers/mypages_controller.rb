class MypagesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @sent_messages = Message.where(user_id: current_user.id)
    @received_messages = Message.where(wish_list_id: current_user.wish_lists.ids)
    @share_message = Message.find_by!(wish_list_id: current_user.wish_lists.ids)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash[:error] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache)
  end
end
