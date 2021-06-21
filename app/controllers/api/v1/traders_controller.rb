class Api::V1::TradersController < ApplicationController
  before_action :set_trader, only: [:show, :update, :destroy, :trader_items, :trader_categories]

  # GET /traders
  def index
    @traders = Trader.all

    render json: @traders
  end

  # GET /traders/1
  def show
    render json: @trader, only: [:tradername, :storename, :image_data, :destory]
  end

  def trader_items
    render json: {
      items: @trader.items,
      count: @trader.items_count,
    }
  end

  def trader_categories
    render json: @trader.categories, only: [:id, :name]
  end

  # POST /traders
  def create
    @trader = Trader.new(trader_params)

    if @trader.save
      render json: @trader, only: [:authentication_token] , status: :created
    else
      render json: @trader.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /traders/1
  def update
    @trader.image_data = params[:image]
    if @trader.save
      render json: @trader
    else
      render json: @trader.errors, status: :unprocessable_entity
    end
  end

  # DELETE /traders/1
  def destroy
    @trader.destroy
  end

  private
    # Only allow a list of trusted parameters through.
    def trader_params
      params.require(:trader).permit(:storename, :tradername, :email, :password, :image)
    end
end
