require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "user can only like a photo once" do
    Like.create!(user: users(:demo), photo: photos(:lake))
    dup = Like.new(user: users(:demo), photo: photos(:lake))
    refute dup.valid?
  end

  test "different users can like the same photo" do
    Like.create!(user: users(:demo),  photo: photos(:lake))
    Like.create!(user: users(:other), photo: photos(:lake))
    assert_equal 2, photos(:lake).reload.likes_count
  end

  test "counter cache increments and decrements" do
    assert_difference -> { photos(:lake).reload.likes_count }, +1 do
      Like.create!(user: users(:demo), photo: photos(:lake))
    end

    assert_difference -> { photos(:lake).reload.likes_count }, -1 do
      Like.find_by(user: users(:demo), photo: photos(:lake)).destroy
    end
  end
end
