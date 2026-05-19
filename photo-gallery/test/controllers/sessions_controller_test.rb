require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "testuser", password: "password123")
  end

  test "should get login page" do
    get login_url
    assert_response :success
    assert_select "h1", "Photo Gallery"
  end

  test "should login with valid credentials" do
    post login_url, params: { username: "testuser", password: "password123" }
    assert_redirected_to photos_path
    follow_redirect!
    assert_equal @user.id, session[:user_id]
  end

  test "demo credentials should login successfully" do
    demo = User.create(username: "demo", password: "password123")

    post login_url, params: { username: "demo", password: "password123" }

    assert_redirected_to photos_path
    assert_equal demo.id, session[:user_id]
  end

  test "should not login with invalid username" do
    post login_url, params: { username: "wronguser", password: "password123" }
    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end

  test "should not login with invalid password" do
    post login_url, params: { username: "testuser", password: "wrongpass" }
    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end

  test "should logout and clear session" do
    post login_url, params: { username: "testuser", password: "password123" }
    assert_not_nil session[:user_id]

    delete logout_url
    assert_nil session[:user_id]
    assert_redirected_to login_path
  end

  test "should display error on invalid credentials" do
    post login_url, params: { username: "testuser", password: "wrongpass" }
    assert_select ".alert-error"
  end
end
