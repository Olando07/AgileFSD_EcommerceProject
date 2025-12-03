require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get :action
    assert_response :success
  end

  test "should get create" do
    get :action
    assert_response :success
  end

  test "should get destroy" do
    get :action
    assert_response :success
  end
end
