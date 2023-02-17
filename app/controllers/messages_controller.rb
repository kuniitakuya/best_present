class MessagesController < ApplicationController
  def new
    @message = Message.new
    @wish_list = WishList.find(params[:wish_list_id])
    @item = @wish_list.items.all
  end

  def create
    @wish_list = current_user.wish_lists.find(params[:wish_list_id])
    @messages = current_user.messages.new(message_params)
    if @messages.save
      redirect_to mypage_path, success: t('defaults.message.add', item: Message.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_add', item: Message.model_name.human)
      render :new
    end
  end

  def destroy

  end

  private

  def message_params
    params.require(:message).permit(:text, :message_image, :message_image_cache).merge(item_id: @item.id)
  end
end
