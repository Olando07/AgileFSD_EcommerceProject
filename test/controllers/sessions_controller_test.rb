require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should get create" do
    user = users(:test_user)
    post login_path, params: { name: user.name, password: "password" }
    assert_response :redirect
  end

  test "should get destroy" do
    delete logout_path rescue delete "/sessions/1"
    assert_response :redirect
  end
end
