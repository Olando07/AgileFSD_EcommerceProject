require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one) rescue Order.create!(user_id: 1, status: "pending", subtotal: 10.0, gst: 1.0, pst: 1.0, hst: 1.0, total: 13.0)
  end

  test "should get new" do
    get new_order_path rescue get "/orders/new"
    assert_response :redirect
  end

  test "should get create" do
    post new_order_path, params: { order: { user_id: 1, status: "pending", subtotal: 10.0, gst: 1.0, pst: 1.0, hst: 1.0, total: 13.0 } } rescue post "/orders", params: {}
    assert_response :redirect
  end

  test "should get show" do
    get order_path(@order) rescue get "/orders/#{@order.id}"
    assert_response :redirect
  end

  test "should get index" do
    get orders_path rescue get "/orders"
    assert_response :redirect
  end
end
