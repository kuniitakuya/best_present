class ItemsController < ApplicationController

  def new
    search(params)
    @wish_list = current_user.wish_lists.find(params[:wish_list_id])
  end

  def create
    @item = current_user.items.new(item_params)
    @wish_list = current_user.wish_lists.find(params[:wish_list_id])
    if @item.save
      redirect_to wish_list_path(@wish_list), success: t('defaults.message.add', item: Item.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_add', item: Item.model_name.human)
      render :new
    end
  end

  def destroy
    @item = current_user.items.find(params[:wish_list_id])
    @item.destroy!
    redirect_to request.referer, success: t('defaults.message.deleted', item: Item.model_name.human)
  end

  private

  def search(params)
    @items =[]
    @keyword = params[:keyword]
    if @keyword.present?
      @results = RakutenWebService::Ichiba::Item.search(keyword: @keyword, page: params[:page],
          hits: 30)

      @results.each do |result|
        item = Item.new(read(result))
        @items << item
      end
    end
    @items = Kaminari.paginate_array(@items).page(params[:page])
  end

  def read(result)
    item_name = result['itemName']
    item_price = result['itemPrice']
    image_url = result["mediumImageUrls"][0]
    item_url = result["itemUrl"]
    {
      item_name: item_name,
      price: item_price,
      image: image_url,
      url: item_url
    }
  end

  def item_params
    params.require(:item).permit(:item_name, :price, :image, :url, :save_list).merge(wish_list_id: params[:wish_list_id])
  end
end
