require 'rails_helper'

RSpec.describe Photo, type: :model do
  # Requirement 2: "Seed the photos into your database from the CSV"
  it "can be seeded from the CSV" do
    load Rails.root.join("db/seeds.rb")
    expect(Photo.count).to eq 10
  end

  # Requirement 3: "Like counts must persist in the database"
  it "tracks its like count through the likes association" do
    photo = Photo.create!(pexels_id: 99, url: "http://example.com", photographer: "Test",
      photographer_url: "http://example.com", image_url: "http://example.com/img.jpg", alt: "test")
    user = User.create!(email: "liker@example.com", password: "password")

    expect(photo.likes.count).to eq 0
    photo.likes.create!(user: user)
    expect(photo.likes.count).to eq 1
  end
end
