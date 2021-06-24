class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_trader, only: [:create, :show, :update, :destroy]
  # GET /items
  def index
    @items = Item.all

    render json: @items
  end

  # GET /items/1
  def show
    @owner = @trader.items.include?(@item)
    render json: {
      item: @item,
      category: @item.category.name,
      owner: @owner
    }
  end

  # POST /items
  def create
    if @trader.items_count <= @trader.items_limit
      @item = Item.new(item_params)
      @item.trader_id = @trader.id
      if @item.save
        render json: @item, status: :created
      else
        render json: @item.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: {failure: "You have reached your limit, please upgrade your plan."}
    end
  end

  # PATCH/PUT /items/1
  def update
    @owner = @trader.items.include?(@item)
    if @owner
      if @item.update(item_params)
        render json: {message: "Updated successfully."}
      else
        render json: @item.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: {failure: "You're not authorized to do that ya 3el2."}
    end
  end

  # DELETE /items/1
  def destroy
    @owner = @trader.items.include?(@item)
    if @owner
      @item.destroy
      render json: {message: "Deleted successfully."}
    else
      render json: {failure: "You're not authorized to do that ya 3el2."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :description, :price, :size, :unit, :quantity, :category_id, :trader_id, :image_data)
    end
end
