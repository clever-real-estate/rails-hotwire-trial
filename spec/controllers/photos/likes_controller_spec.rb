require 'rails_helper'

RSpec.describe Photos::LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:photo) { create(:photo, title: "Test Photo") }

  before do
    sign_in user
  end

  describe "#create" do
    it "creates a like record" do
      expect {
        post :create, params: { photo_id: photo.id, format: :turbo_stream }
      }.to change { Like.count }.by(1)
    end

    it "responds with turbo_stream" do
      post :create, params: { photo_id: photo.id, format: :turbo_stream }

      expect(response).to have_http_status(:success)
      expect(response.media_type).to include("turbo-stream")
    end

    it "sets correct instance variables for turbo stream" do
      post :create, params: { photo_id: photo.id, format: :turbo_stream }

      expect(assigns(:photos)).not_to be_nil
      expect(assigns(:liked_photo_ids)).not_to be_nil
      expect(assigns(:photos_view)).to eq(:all)
    end

    it "respects session filter preference" do
      session[:photos_filter] = :liked
      post :create, params: { photo_id: photo.id, format: :turbo_stream }

      expect(assigns(:photos_view)).to eq(:liked)
    end

    it "includes photo in response when in all filter" do
      session[:photos_filter] = :all
      post :create, params: { photo_id: photo.id, format: :turbo_stream }

      expect(assigns(:photos)).to include(photo)
    end

    it "excludes photo when in not_liked filter after liking" do
      session[:photos_filter] = :not_liked
      post :create, params: { photo_id: photo.id, format: :turbo_stream }

      expect(assigns(:photos)).not_to include(photo)
    end

    it "includes photo when in liked filter after liking" do
      session[:photos_filter] = :liked
      post :create, params: { photo_id: photo.id, format: :turbo_stream }

      expect(assigns(:photos)).to include(photo)
    end
  end

  describe "#destroy" do
    before do
      user.likes.create!(photo: photo)
    end

    it "removes a like record" do
      expect {
        delete :destroy, params: { photo_id: photo.id, format: :turbo_stream }
      }.to change { Like.count }.by(-1)
    end

    it "responds with turbo_stream" do
      delete :destroy, params: { photo_id: photo.id, format: :turbo_stream }

      expect(response).to have_http_status(:success)
      expect(response.media_type).to include("turbo-stream")
    end

    it "respects session filter preference" do
      session[:photos_filter] = :not_liked
      delete :destroy, params: { photo_id: photo.id, format: :turbo_stream }

      expect(assigns(:photos_view)).to eq(:not_liked)
    end
  end
end
