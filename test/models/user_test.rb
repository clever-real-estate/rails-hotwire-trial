require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "rejects duplicate email regardless of case" do
    dup = User.new(email: "DEMO@clever.EXAMPLE", password: "password")
    refute dup.valid?
    assert_includes dup.errors[:email].join, "taken"
  end

  test "normalizes email to lowercase, stripped" do
    user = User.create!(email: "  NEW@clever.Example  ", password: "password")
    assert_equal "new@clever.example", user.email
  end

  test "authenticate_by returns user with correct password" do
    assert_equal users(:demo), User.authenticate_by(email: "demo@clever.example", password: "password")
  end

  test "authenticate_by returns nil with wrong password" do
    assert_nil User.authenticate_by(email: "demo@clever.example", password: "wrong")
  end

  test "liked? reflects existing like" do
    photo = photos(:lake)
    refute users(:demo).liked?(photo)
    Like.create!(user: users(:demo), photo: photo)
    assert users(:demo).reload.liked?(photo)
  end
end
