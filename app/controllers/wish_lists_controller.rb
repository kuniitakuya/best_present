class WishListsController < ApplicationController
  before_action :set_wishlist, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.wish_lists.ransack(params[:q])
    @wish_lists = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @item = @wish_list.items.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @wish_list = WishList.new
  end

  def edit; end

  def create
    @wish_list = current_user.wish_lists.build(wish_list_params)
    if @wish_list.save
      redirect_to wish_list_path(@wish_list), success: t('defaults.message.created', item: WishList.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: WishList.model_name.human)
      render :new
    end
  end

  def update
    if @wish_list.update(wish_list_params)
      redirect_to @wish_list, success: t('defaults.message.updated', item: WishList.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @wish_list.destroy!
    redirect_to request.referer, success: t('defaults.message.deleted', item: WishList.model_name.human)
  end

  private

  def set_wishlist
    @wish_list = WishList.find(params[:id])
  end

  def wish_list_params
    params.require(:wish_list).permit(:list_name)
  end
end
