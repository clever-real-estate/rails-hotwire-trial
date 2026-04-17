require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  let(:user) { create(:user) }
  let(:photo1) { create(:photo, title: "Photo 1") }
  let(:photo2) { create(:photo, title: "Photo 2") }

  before do
    sign_in user
    # Explicitly create the photos by accessing the lets
    photo1
    photo2
    user.likes.create!(photo: photo1)
  end

  describe "#index" do
    it "loads successfully" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "sets photos_view to all by default" do
      get :index
      expect(assigns(:photos_view)).to eq(:all)
    end

    it "loads all photos" do
      get :index
      expect(assigns(:photos).count).to eq(2)
    end
  end

  describe "#filter_photos" do
    context "with all filter" do
      it "returns all photos" do
        get :filter_photos, params: { filter: :all, format: :turbo_stream }

        expect(response).to have_http_status(:success)
        expect(assigns(:photos_view)).to eq(:all)
        expect(assigns(:photos).count).to eq(2)
      end
    end

    context "with liked filter" do
      it "returns only liked photos" do
        get :filter_photos, params: { filter: :liked, format: :turbo_stream }

        expect(response).to have_http_status(:success)
        expect(assigns(:photos_view)).to eq(:liked)
        expect(assigns(:photos).count).to eq(1)
        expect(assigns(:photos)).to include(photo1)
      end
    end

    context "with not_liked filter" do
      it "returns only not liked photos" do
        get :filter_photos, params: { filter: :not_liked, format: :turbo_stream }

        expect(response).to have_http_status(:success)
        expect(assigns(:photos_view)).to eq(:not_liked)
        expect(assigns(:photos).count).to eq(1)
        expect(assigns(:photos)).to include(photo2)
      end
    end

    it "stores filter in session" do
      get :filter_photos, params: { filter: :liked, format: :turbo_stream }

      expect(session[:photos_filter]).to eq(:liked)
    end

    it "returns liked photo ids for current user" do
      get :filter_photos, params: { filter: :all, format: :turbo_stream }

      liked_ids = assigns(:liked_photo_ids)
      expect(liked_ids).to include(photo1.id)
      expect(liked_ids).not_to include(photo2.id)
    end

    context "with invalid filter" do
      it "defaults to all photos" do
        get :filter_photos, params: { filter: :invalid, format: :turbo_stream }

        expect(response).to have_http_status(:success)
        expect(assigns(:photos).count).to eq(2)
      end
    end

    context "without filter param" do
      it "defaults to all photos" do
        get :filter_photos, params: { format: :turbo_stream }

        expect(response).to have_http_status(:success)
        expect(assigns(:photos).count).to eq(2)
      end
    end
  end
end
