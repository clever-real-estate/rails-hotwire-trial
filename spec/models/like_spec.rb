require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:photo) do
    Photo.create!(pexels_id: 1, url: "http://example.com", photographer: "Test",
      photographer_url: "http://example.com", image_url: "http://example.com/img.jpg", alt: "test")
  end

  # Requirement 3: "Each user can like a photo only once"
  it "enforces one like per user per photo" do
    Like.create!(user: user, photo: photo)
    duplicate = Like.new(user: user, photo: photo)
    expect(duplicate).not_to be_valid
  end

  # Requirement 3: a different user CAN also like the same photo
  it "allows different users to like the same photo" do
    Like.create!(user: user, photo: photo)
    other_user = User.create!(email: "other@example.com", password: "password")
    expect(Like.new(user: other_user, photo: photo)).to be_valid
  end
end
