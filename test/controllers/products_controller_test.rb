require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get :action
    assert_response :success
  end

  test "should get show" do
    get :action
    assert_response :success
  end
end
