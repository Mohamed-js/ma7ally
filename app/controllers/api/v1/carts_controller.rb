class Api::V1::CartsController < ApplicationController
  before_action :set_trader_by_storename, only: [:index, :create]
  before_action :set_user, only: [:index, :show, :create, :update, :destroy]
  before_action :set_cart, only: [:show, :update, :destroy]

  # GET /carts
  def index
    p @trader
    @carts = @user.carts.where(trader_id: @trader.id)
    render json: @carts, only: [:id, :quantity], include: [:item]
  end

  # POST /carts
  def create
    @cart = Cart.new(quantity: params[:quantity], item_id: params[:item_id], user_id: @user.id, trader_id: @trader.id)
    if @cart.save
      render json: {message: "Added #{params[:quantity]} of the #{@cart.item.name} to your cart!"}, status: :created
    else
      p @cart.errors.full_messages
      render json: @cart.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    if @cart.destroy
      render json: {message: "Removed successfully!"}, status: :created
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = @user.carts.find_by(item_id: params[:id])
    end

    # Set trader
    def set_trader_by_storename
      @trader = Trader.find_by(storename: params[:storename])
    end
end
