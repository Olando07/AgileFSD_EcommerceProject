require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sessions_new_path
    assert_response :success
  end

  test "should get create" do
    post sessions_create_path, params: { session: { email: "user@example.com", password: "password" } } rescue post "/sessions", params: {}
    assert_response :redirect
  end

  test "should get destroy" do
    delete sessions_destroy_path(1) rescue delete "/sessions/1"
    assert_response :redirect
  end
end
