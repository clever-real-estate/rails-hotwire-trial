require "rails_helper"

RSpec.describe "Photos", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password") }

  describe "GET /photos" do
    it "redirects unauthenticated users to sign in" do
      get photos_path
      expect(response).to redirect_to(sign_in_path)
    end

    it "allows authenticated users" do
      post sign_in_path, params: { email: user.email, password: "password" }

      get photos_path

      expect(response).to have_http_status(:ok)
    end

    it "renders photos for authenticated users" do
      photo = Photo.create!(
        image_url: "http://example.com/photo.jpg",
        photographer: "Test Photographer",
        source_url: "http://example.com",
        alt: "Test photo"
      )

      post sign_in_path, params: { email: user.email, password: "password" }

      get photos_path

      expect(response.body).to include(photo.photographer)
    end
  end
end