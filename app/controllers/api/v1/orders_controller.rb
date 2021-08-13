class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  before_action :set_trader, only: [:index]
  before_action :set_user, only: [:create]

  # GET /orders
  def index
    @orders = @trader.orders

    render json: @orders, only: [:address, :phone, :phone2, :quantity, :total, :currency], include: [:items, :user]
    # render json: @orders, only: [:address, :phone, :phone2, :quantity, :total, :currency],:include => {:user => {:only => [:name]}, :items => {:include => :category, :only => [:name]}}
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @trader = Trader.find_by(storename: params[:storename])

    @order = Order.new(user_id: @user.id, trader_id: @trader.id, address: "#{params[:address]} - #{params[:city]} - #{params[:country]}", phone: params[:phone], currency: "$", payment_method: params[:payment_method])
    if params[:phone2]
      @order[:phone2] = params[:phone2]
    end
    if @order.save
      @cart_items = @user.carts.where(trader_id: @trader.id)
      @cart_items.each do |cart_item|
        order_item = OrderItem.new(order_id: @order.id, item_id: cart_item.item_id, quantity: cart_item.quantity, total: cart_item.quantity * cart_item.item.price, user_id: cart_item.user_id, status: "pending", trader_id: @trader.id )
        if order_item.save
          @order.total += (order_item.quantity * order_item.item.price)
          cart_item.destroy
        end
      end
      @order.save
      render json: {message: "Order placed successfully!"}, status: :ok
    else
      render json: @order.errors.full_messages, status: :unprocessable_entity
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
    # def order_params
    #   params.require(:order).permit(:item_id, :user_id, :trader_id, :quantity)
    # end
end
