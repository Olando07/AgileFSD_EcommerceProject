require "test_helper"

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get :action
    assert_response :success
  end

  test "should get add" do
    get :action
    assert_response :success
  end

  test "should get remove" do
    get :action
    assert_response :success
  end

  test "should get update" do
    get :action
    assert_response :success
  end
end
