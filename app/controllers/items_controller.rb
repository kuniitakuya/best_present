class ItemsController < ApplicationController
  def new
    search(params)
    @wish_list = current_user.wish_lists.find(params[:wish_list_id])
  end

  def create
    @wish_list = current_user.wish_lists.find(params[:wish_list_id])
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to wish_list_path(@wish_list), success: t('defaults.message.add', item: Item.model_name.human)
    else
      flash.now[:error] = t('defaults.message.not_add', item: Item.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy!
    redirect_to request.referer, success: t('defaults.message.deleted', item: Item.model_name.human)
  end

  private

  def validate_keyword(keyword)
    errors = []
    errors << '検索キーワード全体は半角で128文字以内で指定する必要があります' if keyword.length > 128
    keywords = keyword.split
    keywords.each do |word|
      errors << '各検索キーワードは半角2文字 もしくは 全角1文字 以上で指定する必要があります' if word.length < 2 && !word.match?(/\p{Hiragana}|\p{Katakana}|\p{Punct}/)
      errors << 'ひらがな・カタカナ・記号の場合は2文字以上で指定する必要があります' if word.length < 2 && word.match?(/\p{Hiragana}|\p{Katakana}|\p{Punct}/)
    end
    errors
  end

  def search(params)
    @items = []
    @keyword = params[:keyword]
    if @keyword.present?
      errors = validate_keyword(@keyword)
      if errors.empty?
        page_count = 5
        (1..page_count).each do |page|
          @results = RakutenWebService::Ichiba::Item.search(keyword: @keyword,
                                                            page:,
                                                            hits: 30,
                                                            imageFlag: 1)
          @results.each do |result|
            item = Item.new(read(result))
            @items << item
          end
        end
      else
        @search_errors = errors
      end
    end
    @items = Kaminari.paginate_array(@items).page(params[:page])
  end

  def read(result)
    item_name = result['itemName'].truncate(40, separator: '.')
    item_price = result['itemPrice']
    image_url = result["mediumImageUrls"][0].sub('_ex=128x128', '_ex=560x560')
    item_url = result["itemUrl"]
    {
      item_name:,
      price: item_price,
      image: image_url,
      url: item_url
    }
  end

  def item_params
    params.require(:item).permit(:item_name, :price, :image, :url, :save_list).merge(wish_list_id: @wish_list.id)
  end
end
