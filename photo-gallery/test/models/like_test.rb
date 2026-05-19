require "test_helper"

class LikeTest < ActiveSupport::TestCase
  setup do
    @user = User.create(username: "testuser", password: "pass123")
    @photo = Photo.create(id: 1, url: "http://example.com", src_medium: "http://example.com/med.jpg")
    @like = Like.create(user: @user, photo: @photo)
  end

  test "should create like with valid attributes" do
    user = User.create(username: "user2", password: "pass")
    like = Like.new(user: user, photo: @photo)
    assert like.valid?
  end

  test "should belong to user" do
    assert_respond_to @like, :user
  end

  test "should belong to photo" do
    assert_respond_to @like, :photo
  end

  test "should not allow duplicate likes from same user for same photo" do
    duplicate_like = Like.new(user: @user, photo: @photo)
    assert_not duplicate_like.valid?
  end

  test "user can like different photos" do
    photo2 = Photo.create(id: 2, url: "http://test.com", src_medium: "http://test.com/img.jpg")
    like2 = Like.new(user: @user, photo: photo2)
    assert like2.valid?
  end

  test "different users can like same photo" do
    user2 = User.create(username: "user2", password: "pass")
    like2 = Like.new(user: user2, photo: @photo)
    assert like2.valid?
  end
end
