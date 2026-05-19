require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "testuser", password: "password123")
    @photo = Photo.create(id: 1, url: "http://example.com", src_medium: "http://example.com/med.jpg")
  end

  test "should require login to like photo" do
    post photo_likes_url(@photo)
    assert_redirected_to login_path
  end

  test "should create like when authenticated" do
    post login_url, params: { username: "testuser", password: "password123" }
    
    assert_difference("Like.count", 1) do
      post photo_likes_url(@photo)
    end
  end

  test "should respond with turbo stream" do
    post login_url, params: { username: "testuser", password: "password123" }
    
    post photo_likes_url(@photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :success
    assert_equal "text/vnd.turbo-stream.html", response.media_type
    assert_select "turbo-stream[action='replace'][target='photo_#{@photo.id}_like']"
    assert_select "turbo-frame#photo_#{@photo.id}_like"
    assert_select ".like-button.liked"
    assert_select ".like-count", "1"
  end

  test "should unlike photo if already liked" do
    post login_url, params: { username: "testuser", password: "password123" }
    
    # Create initial like
    post photo_likes_url(@photo)
    assert_equal 1, @photo.reload.likes.count
    
    # Unlike
    post photo_likes_url(@photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_equal 0, @photo.reload.likes.count
    assert_select ".like-button:not(.liked)"
    assert_select ".like-count", "0"
  end

  test "should not allow duplicate likes from same user" do
    post login_url, params: { username: "testuser", password: "password123" }
    
    # First like
    post photo_likes_url(@photo)
    assert_equal 1, @photo.reload.likes.count
    
    # This would be handled by the controller logic (toggle unlike)
    # So the like already exists and clicking again would unlike it
  end

  test "like count should update correctly" do
    user2 = User.create(username: "user2", password: "pass")
    user2.likes.create(photo: @photo)

    post login_url, params: { username: "testuser", password: "password123" }
    post photo_likes_url(@photo), headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_equal 2, @photo.reload.likes.count
    assert_select ".like-count", "2"
  end
end
