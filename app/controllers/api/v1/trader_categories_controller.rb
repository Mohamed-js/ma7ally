class TraderCategoriesController < ApplicationController
  before_action :set_trader_category, only: [:show, :update, :destroy]

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
    @trader_category = TraderCategory.new(trader_category_params)

    if @trader_category.save
      render json: @trader_category, status: :created, location: @trader_category
    else
      render json: @trader_category.errors, status: :unprocessable_entity
    end
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
      params.require(:trader_category).permit(:trader_id, :category_id)
    end
end
