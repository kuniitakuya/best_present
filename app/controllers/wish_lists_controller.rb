class WishListsController < ApplicationController
  before_action :set_wishlist, only: [:edit, :update, :destroy]

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
    @wish_list = current_user.wish_lists.find(params[:id])
  end

  def update
    if @wish_list.update(wish_list_params)
      redirect_to @wish_list, success: t('defaults.message.updated', item: WishList.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: WishList.model_name.human)
      render :edit
    end
  end

  def destroy
    @wish_list.destroy!
    redirect_to wish_lists_path, success: t('defaults.message.deleted', item: WishList.model_name.human)
  end


  private

  def set_wishlist
    @wish_list = current_user.wish_lists.find(params[:id])
  end

  def wish_list_params
    params.require(:wish_list).permit(:list_name)
  end
end
