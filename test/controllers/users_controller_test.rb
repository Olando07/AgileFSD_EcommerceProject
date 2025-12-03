require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get :action
    assert_response :success
  end

  test "should get create" do
    get :action
    assert_response :success
  end
end
