require 'rails_helper'

RSpec.describe "Likes Turbo Stream", type: :request do
  let(:user) { create(:user) }
  let(:photo) { create(:photo, title: "Test Photo") }

  before do
    login_as user, scope: :user
    photo  # Ensure photo is created
  end

  describe "create like action" do
    it "responds with turbo_stream format" do
      post "/photos/#{photo.id}/like", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    end

    it "includes filter_photos template in response" do
      post "/photos/#{photo.id}/like", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("turbo-stream")
      expect(response.body).to include("photo_gallery")
    end

    it "creates a like record" do
      expect {
        post "/photos/#{photo.id}/like", headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.to change { Like.count }.by(1)

      expect(user.likes.exists?(photo: photo)).to be true
    end
  end

  describe "destroy like action" do
    before do
      user.likes.create!(photo: photo)
    end

    it "responds with turbo_stream format" do
      delete "/photos/#{photo.id}/like", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    end

    it "includes filter_photos template in response" do
      delete "/photos/#{photo.id}/like", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("turbo-stream")
      expect(response.body).to include("photo_gallery")
    end

    it "destroys the like record" do
      expect {
        delete "/photos/#{photo.id}/like", headers: { "Accept" => "text/vnd.turbo-stream.html" }
      }.to change { Like.count }.by(-1)

      expect(user.likes.exists?(photo: photo)).to be false
    end
  end

  describe "filter session respect" do
    it "respects current filter session on like" do
      post "/photos/#{photo.id}/like", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("photo_gallery")
    end

    it "respects current filter session on unlike" do
      user.likes.create!(photo: photo)

      delete "/photos/#{photo.id}/like", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("photo_gallery")
    end
  end
end
