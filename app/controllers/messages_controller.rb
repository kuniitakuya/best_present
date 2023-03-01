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
      image = OgpCreater.build(@message.text)
      @message.update!(message_image: image)
      redirect_to mypage_path, success: t('defaults.message.created', item: Message.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Message.model_name.human)
      render :new
    end
  end

  def destroy
    @message = current_user.messages.find(params[:id])
    @message.destroy!
    redirect_to request.referer, success: t('defaults.message.deleted', item: Message.model_name.human)
  end

  private

  def message_params
    params.require(:message).permit(:text, :select_item, :receiver, :sender).merge(wish_list_id: @wish_list.id)
  end
end
