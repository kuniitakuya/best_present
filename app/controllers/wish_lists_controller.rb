class WishListsController < ApplicationController
  def index
    @wish_lists = WishList.all.includes(:user).order(created_at: :desc)
  end

  def show

  end

  def edit

  end
end
