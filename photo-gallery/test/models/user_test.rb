require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.create(username: "testuser", password: "password123")
  end

  test "should create user with valid attributes" do
    user = User.new(username: "newuser", password: "securepass")
    assert user.valid?
  end

  test "should require username" do
    user = User.new(password: "securepass")
    assert_not user.valid?
  end

  test "should require password" do
    user = User.new(username: "newuser")
    assert_not user.valid?
  end

  test "username should be unique" do
    user = User.new(username: "testuser", password: "pass")
    assert_not user.valid?
  end

  test "should authenticate with correct password" do
    assert @user.authenticate("password123")
  end

  test "should not authenticate with incorrect password" do
    assert_not @user.authenticate("wrongpass")
  end

  test "should have many likes" do
    assert_respond_to @user, :likes
  end

  test "should have many liked_photos through likes" do
    assert_respond_to @user, :liked_photos
  end

  test "should destroy associated likes when destroyed" do
    photo = Photo.create(id: 1, url: "http://example.com", src_medium: "http://example.com/med.jpg")
    @user.likes.create(photo: photo)
    
    assert_difference("Like.count", -1) do
      @user.destroy
    end
  end
end
