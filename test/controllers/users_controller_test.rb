require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_new_path rescue get "/users/new"
    assert_response :success
  end

  test "should get create" do
    post users_create_path(), params: { user: { email: "test@example.com", password: "password", name: "Test" } } rescue post "/users", params: {}
    assert_response :redirect
  end
end
