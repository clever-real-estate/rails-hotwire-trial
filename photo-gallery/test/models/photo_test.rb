require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  setup do
    @photo = Photo.create(id: 1, url: "http://example.com", src_medium: "http://example.com/med.jpg")
  end

  test "should create photo with valid attributes" do
    photo = Photo.new(id: 999, url: "http://test.com", src_medium: "http://test.com/img.jpg")
    assert photo.valid?
  end

  test "should have many likes" do
    assert_respond_to @photo, :likes
  end

  test "should have many liking_users through likes" do
    assert_respond_to @photo, :liking_users
  end

  test "should destroy associated likes when destroyed" do
    user = User.create(username: "testuser", password: "pass123")
    @photo.likes.create(user: user)

    assert_difference("Like.count", -1) do
      @photo.destroy
    end
  end

  test "should count likes correctly" do
    user1 = User.create(username: "user1", password: "pass")
    user2 = User.create(username: "user2", password: "pass")

    @photo.likes.create(user: user1)
    @photo.likes.create(user: user2)

    assert_equal 2, @photo.likes.count
  end
end
