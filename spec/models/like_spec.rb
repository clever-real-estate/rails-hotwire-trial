require "rails_helper"

RSpec.describe Like, type: :model do
  describe "associations" do
    it "belongs to a user" do
      expect(likes(:like_one).user).to eq(users(:user_one))
    end

    it "belongs to a photo" do
      expect(likes(:like_one).photo).to eq(photos(:photo_one))
    end
  end

  describe "validations" do
    it "prevents a user from liking the same photo twice" do
      duplicate = Like.new(user: users(:user_one), photo: photos(:photo_one))
      expect(duplicate).not_to be_valid
    end

    it "allows different users to like the same photo" do
      second_like = Like.new(user: users(:user_two), photo: photos(:photo_one))
      expect(second_like).to be_valid
    end
  end
end
