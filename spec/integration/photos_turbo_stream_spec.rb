require 'rails_helper'

RSpec.describe "Photos Turbo Stream", type: :request do
  let(:user) { create(:user) }
  let(:photo1) { create(:photo, title: "Photo One") }
  let(:photo2) { create(:photo, title: "Photo Two") }

  before do
    login_as user, scope: :user
    photo1
    photo2
    user.likes.create!(photo: photo1)
  end

  describe "filter_photos action" do
    it "responds with turbo_stream format" do
      get "/photos/filter_photos?filter=all", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    end

    it "includes photo_gallery replacement in response" do
      get "/photos/filter_photos?filter=liked", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("turbo-stream")
      expect(response.body).to include("photo_gallery")
      expect(response.body).to include("Photo One")
      expect(response.body).not_to include("Photo Two")
    end

    it "stores filter state in session" do
      get "/photos/filter_photos?filter=liked", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(session[:photos_filter]).to eq(:liked)
    end
  end

  describe "filter variations" do
    it "returns only liked photos when liked filter is used" do
      get "/photos/filter_photos?filter=liked", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Photo One")
      expect(response.body).not_to include("Photo Two")
    end

    it "returns only not liked photos when not_liked filter is used" do
      get "/photos/filter_photos?filter=not_liked", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).not_to include("Photo One")
      expect(response.body).to include("Photo Two")
    end

    it "returns all photos when all filter is used" do
      get "/photos/filter_photos?filter=all", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Photo One")
      expect(response.body).to include("Photo Two")
    end

    it "defaults to all photos when no filter provided" do
      get "/photos/filter_photos", headers: { "Accept" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Photo One")
      expect(response.body).to include("Photo Two")
    end
  end
end
