require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "testuser", password: "password123")
    @photo = Photo.create(id: 1, url: "http://example.com", photographer: "Test Photographer", src_medium: "http://example.com/med.jpg")
  end

  test "should redirect to login when not authenticated" do
    get photos_url
    assert_redirected_to login_path
  end

  test "should get photos index when authenticated" do
    post login_url, params: { username: "testuser", password: "password123" }
    get photos_url
    assert_response :success
  end

  test "should display all photos in gallery" do
    post login_url, params: { username: "testuser", password: "password123" }
    get photos_url
    
    assert_response :success
    assert_select "h1", "All Photos"
    assert_select ".photo-card"
    assert_select ".photographer-name", "Test Photographer"
  end

  test "should display like button for each photo" do
    post login_url, params: { username: "testuser", password: "password123" }
    get photos_url
    
    assert_response :success
    assert_select ".like-button"
    assert_select ".like-count"
  end

  test "should display photographer and link info" do
    post login_url, params: { username: "testuser", password: "password123" }
    get photos_url
    
    assert_response :success
    assert_select "a[href='http://example.com']"
  end
end
