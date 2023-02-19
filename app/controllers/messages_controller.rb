class MessagesController < ApplicationController
  def new
    @message = Message.new
    @wish_list = WishList.find(params[:wish_list_id])
    @item = @wish_list.items.all
  end

  def create
    @wish_list = WishList.find(params[:wish_list_id])
    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to mypage_path, success: t('defaults.message.created', item: Message.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Message.model_name.human)
      render :new
    end
  end

  def destroy

  end

  private

  def message_params
    params.require(:message).permit(:text, :message_image, :message_image_cache, :select_item).merge(wish_list_id: @wish_list.id)
  end
end
