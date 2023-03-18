class Admin::WishListsController < Admin::BaseController
  before_action :set_wish_list, only: %i[show edit update destroy]

  def index
    @search = WishList.ransack(params[:q])
    @wish_lists = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @wish_list.update(wish_list_params)
      redirect_to admin_wish_list_path(@wish_list), success: t('defaults.message.updated', item: WishList.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: WishList.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @wish_list.destroy!
    redirect_to admin_wish_lists_path, success: t('defaults.message.deleted', item: WishList.model_name.human)
  end

  private

  def set_wish_list
    @wish_list = WishList.find(params[:id])
  end

  def wish_list_params
    params.require(:wish_list).permit(:list_name)
  end
end
