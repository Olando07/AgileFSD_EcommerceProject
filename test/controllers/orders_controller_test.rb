require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get :action
    assert_response :success
  end

  test "should get create" do
    get :action
    assert_response :success
  end

  test "should get show" do
    get :action
    assert_response :success
  end

  test "should get index" do
    get :action
    assert_response :success
  end
end
