require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get items_url, as: :json
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post items_url, params: { item: { category_id: @item.category_id, description: @item.description, image_data: @item.image_data, name: @item.name, price: @item.price, quantity: @item.quantity, size: @item.size, trader_id: @item.trader_id, unit: @item.unit } }, as: :json
    end

    assert_response 201
  end

  test "should show item" do
    get item_url(@item), as: :json
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: { item: { category_id: @item.category_id, description: @item.description, image_data: @item.image_data, name: @item.name, price: @item.price, quantity: @item.quantity, size: @item.size, trader_id: @item.trader_id, unit: @item.unit } }, as: :json
    assert_response 200
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@item), as: :json
    end

    assert_response 204
  end
end
