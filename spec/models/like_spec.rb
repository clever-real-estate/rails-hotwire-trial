require "rails_helper"

RSpec.describe Like, type: :model do
  it "is invalid when the same user likes the same photo twice" do
    user = User.create!(email: "one@example.com", password: "password123", password_confirmation: "password123")
    photo = Photo.create!(
      title: "Test photo",
      photographer: "Test photographer",
      image_url: "https://example.com/photo.jpg",
      source_url: "https://example.com"
    )

    Like.create!(user: user, photo: photo)
    duplicate_like = Like.new(user: user, photo: photo)

    expect(duplicate_like).not_to be_valid
    expect(duplicate_like.errors[:user_id]).to include("has already been taken")
  end
end