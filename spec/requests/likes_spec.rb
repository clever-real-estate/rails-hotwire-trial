require "rails_helper"

RSpec.describe "Likes", type: :request do
  let!(:user) do
    User.create!(
      email: "request@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let!(:photo) do
    Photo.create!(
      title: "Gallery photo",
      photographer: "Photographer",
      image_url: "https://example.com/gallery.jpg",
      source_url: "https://example.com/gallery"
    )
  end

  before do
    sign_in user
  end

  it "creates a like" do
    expect {
      post photo_like_path(photo)
    }.to change(Like, :count).by(1)

    expect(response).to redirect_to(root_path)
  end

  it "destroys a like" do
    Like.create!(user: user, photo: photo)

    expect {
      delete photo_like_path(photo)
    }.to change(Like, :count).by(-1)

    expect(response).to redirect_to(root_path)
  end
end