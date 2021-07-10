class Api::V1::StoreController < ApplicationController
    before_action :set_store

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
       render json: @store.items.where(category_id: params[:cat_id])
    end

    # Item
    def show_item
        @item = @store.items.find(params[:id])
        render json: @item
    end

    private
    def set_store
        @store = Trader.find_by("LOWER(storename)= ?", params[:id].downcase)
    end
end