require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path rescue get "/users/new"
    assert_response :success
  end

   test "should create user" do
    assert_difference("User.count", 1) do
      post users_path, params: {
        user: {
          name: "Test User",
          email: "test@example.com",
          password: "password123",
          password_confirmation: "password123",
          street_address: "123 Test St",
          province_id: provinces(:one).id
        }
      }
    end
    assert_response :redirect
  end
end
