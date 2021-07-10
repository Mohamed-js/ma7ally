class Api::V1::StoreController < ApplicationController
    before_action :set_store, only: [:show, :index]

    # Homepage
    def index
        render json: {
            store: @store,
            categories: @store.categories,
            items: @store.items,
        }
    end

    # Category
    def show
       render json: @store.items.where(category_id: params[:cat_id]), include: :category
    end

    # Item
    def show_item
        @item = Item.find(params[:id])
        render json: @item
    end

    private
    def set_store
        @store = Trader.find_by("LOWER(storename)= ?", params[:id].downcase)
    end
end