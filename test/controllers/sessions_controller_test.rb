require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "GET /sign_in renders the form" do
    get sign_in_path
    assert_response :success
    assert_select "h1", text: "Sign in"
  end

  test "POST /sign_in with valid credentials redirects to photos" do
    post sign_in_path, params: { email: "demo@clever.example", password: "password" }
    assert_redirected_to photos_path
    follow_redirect!
    assert_response :success
  end

  test "POST /sign_in with bad credentials re-renders 422" do
    post sign_in_path, params: { email: "demo@clever.example", password: "wrong" }
    assert_response :unprocessable_entity
    assert_select ".flash__alert", text: /Invalid/
  end

  test "DELETE /sign_out clears session and redirects" do
    post sign_in_path, params: { email: "demo@clever.example", password: "password" }
    delete sign_out_path
    assert_redirected_to sign_in_path
    get photos_path
    assert_redirected_to sign_in_path
  end

  test "unauthenticated GET /photos redirects to sign in" do
    get photos_path
    assert_redirected_to sign_in_path
  end
end
