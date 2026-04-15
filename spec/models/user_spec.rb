# spec/models/user_spec.rb
require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it "has many likes" do
      expect(users(:user_one).likes).to include(likes(:like_one))
    end

    it "has many liked photos through likes" do
      expect(users(:user_one).liked_photos).to include(photos(:photo_one))
    end
  end

  describe "#likes?" do
    it "returns true when user has liked the photo" do
      expect(users(:user_one).likes?(photos(:photo_one))).to be true
    end

    it "returns false when user has not liked the photo" do
      expect(users(:user_one).likes?(photos(:photo_two))).to be false
    end
  end
end
