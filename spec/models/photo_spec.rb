require "rails_helper"

RSpec.describe Photo, type: :model do
  describe "#liked_by?" do
    it "returns true when the user has liked the photo" do
      user = User.create!(email: "two@example.com", password: "password123", password_confirmation: "password123")
      photo = Photo.create!(
        title: "Test photo",
        photographer: "Test photographer",
        image_url: "https://example.com/photo.jpg",
        source_url: "https://example.com"
      )

      Like.create!(user: user, photo: photo)

      expect(photo.liked_by?(user)).to be(true)
    end

    it "returns false when the user has not liked the photo" do
      user = User.create!(email: "three@example.com", password: "password123", password_confirmation: "password123")
      photo = Photo.create!(
        title: "Another photo",
        photographer: "Another photographer",
        image_url: "https://example.com/another.jpg",
        source_url: "https://example.com/another"
      )

      expect(photo.liked_by?(user)).to be(false)
    end
  end
end