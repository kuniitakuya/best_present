class Admin::MessagesController < Admin::BaseController
  before_action :set_message, only: %i[show edit update destroy]

  def index
    @search = Message.ransack(params[:q])
    @messages = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @message.update(message_params)
      image = OgpCreater.build(@message.text)
      @message.update!(message_image: image)
      redirect_to admin_message_path(@message), success: t('defaults.message.updated', item: Message.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Message.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy!
    redirect_to admin_messages_path, success: t('defaults.message.deleted', item: Message.model_name.human)
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:text, :select_item, :receiver, :sender)
  end
end
