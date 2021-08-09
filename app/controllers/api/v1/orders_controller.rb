class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  before_action :set_trader, only: [:index]
  before_action :set_user, only: [:create]

  # GET /orders
  def index
    @orders = @trader.orders

    render json: @orders, only: [:address, :phone, :phone2, :quantity], include: [:item, :user]
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @errors = 0
    @carts = @user.carts
    @carts.each do |cart|
      @order = Order.new(item_id: cart.item_id, user_id: cart.user_id, trader_id: cart.item.trader_id, quantity: cart.quantity, address: "#{params[:address]} - #{params[:city]} - #{params[:country]}", phone: params[:phone], total: (cart.quantity * cart.item.price), currency: "$", payment_method: params[:payment_method])
      if params[:phone2]
        @order[:phone2] = params[:phone2]
      end
      if @order.save
        cart.delete
      else
        @errors = @errors + 1
      end
    end

    if @errors
      # Send message on the user's mail then send successfull message!
      render json: {message: 'Order is placed successfully!'}
    else
      render json: {message: 'Sorry, something is wrong!'}
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:item_id, :user_id, :trader_id, :quantity)
    end
end
