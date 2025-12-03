require "test_helper"

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cart_path rescue get "/cart"
    assert_response :redirect
  end

  test "should get add" do
    post add_cart_path(1), params: { product_id: 1 } rescue post "/cart/add", params: { product_id: 1 }
    assert_response :redirect
  end

  test "should get remove" do
    delete remove_cart_path(1) rescue delete "/cart/remove/1"
    assert_response :redirect
  end

  test "should get update" do
    patch update_cart_path(1), params: { quantity: 2 } rescue patch "/cart/update/1", params: { quantity: 2 }
    assert_response :redirect
  end
end
