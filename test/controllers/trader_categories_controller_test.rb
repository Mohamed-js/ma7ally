require "test_helper"

class TraderCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trader_category = trader_categories(:one)
  end

  test "should get index" do
    get trader_categories_url, as: :json
    assert_response :success
  end

  test "should create trader_category" do
    assert_difference('TraderCategory.count') do
      post trader_categories_url, params: { trader_category: { category_id: @trader_category.category_id, trader_id: @trader_category.trader_id } }, as: :json
    end

    assert_response 201
  end

  test "should show trader_category" do
    get trader_category_url(@trader_category), as: :json
    assert_response :success
  end

  test "should update trader_category" do
    patch trader_category_url(@trader_category), params: { trader_category: { category_id: @trader_category.category_id, trader_id: @trader_category.trader_id } }, as: :json
    assert_response 200
  end

  test "should destroy trader_category" do
    assert_difference('TraderCategory.count', -1) do
      delete trader_category_url(@trader_category), as: :json
    end

    assert_response 204
  end
end
