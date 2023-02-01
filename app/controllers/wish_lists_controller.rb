class WishListsController < ApplicationController
  def index
    @wish_lists = WishList.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @wish_list = WishList.new
  end

  def create
    @wish_list = current_user.wish_lists.new(wish_list_params)
    if @wish_list.save
      redirect_to wish_lists_path, success: t('defaults.message.created', item: WishList.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: WishList.model_name.human)
      render :new
    end
  end

  def show
    @wish_list = WishList.find(params[:id])
  end

  def edit

  end

  private

  def wish_list_params
    params.require(:wish_list).permit(:list_name)
  end
end
