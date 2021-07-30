class Api::V1::CartsController < ApplicationController
  before_action :set_user, only: [:index, :show, :create, :update, :destroy]
  before_action :set_cart, only: [:show, :update, :destroy]

  # GET /carts
  def index
    @carts = @user.carts
    render json: @carts, only: [:id, :quantity], include: [:item]
  end

  # GET /carts/1
  def show
    render json: @cart
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params.merge(user_id: @user.id))

    if @cart.save
      render json: {message: "Added #{cart_params[:quantity]} of the #{@cart.item.name} to your cart!"}, status: :created
    else
      render json: @cart.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
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

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:quantity, :item_id, :user_id)
    end
end
