class Api::V1::TraderCategoriesController < ApplicationController
  before_action :set_trader_category, only: [:show, :update, :destroy]
  before_action :set_trader, only: [:create]

  # GET /trader_categories
  def index
    @trader_categories = TraderCategory.all

    render json: @trader_categories
  end

  # GET /trader_categories/1
  def show
    render json: @trader_category
  end

  # POST /trader_categories
  def create
    categories = params[:trader_category]['categories']
    
    categories.each do |category|
      @trader_category = @trader.trader_categories.build(category_id: category.to_i)
      @trader_category.save
    end
    @trader.first_visit = false
    @trader.save
    render json: {message: "Added successfully."}
  end

  # PATCH/PUT /trader_categories/1
  def update
    if @trader_category.update(trader_category_params)
      render json: @trader_category
    else
      render json: @trader_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trader_categories/1
  def destroy
    @trader_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trader_category
      @trader_category = TraderCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trader_category_params
      params.require(:trader_category).permit(:cats)
    end
end
