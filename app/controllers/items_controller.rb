class ItemsController < ApplicationController
  def search
    if params[:keyword]
      items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      @items_full = []
      items.each do |item|
        @items_full.push(item)
      end
      @items = Kaminari.paginate_array(@items_full).page(params[:page])
    end
  end
end
