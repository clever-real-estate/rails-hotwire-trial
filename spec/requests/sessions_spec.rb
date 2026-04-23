require "rails_helper"

# Requirement 1: Authentication
#   - A sign-in page that gates access to the rest of the app
#   - Users who are not signed in should be redirected to sign in
RSpec.describe "Authentication", type: :request do
  let!(:user) { User.create!(email: "test@example.com", password: "password") }

  describe "sign-in page" do
    it "presents a sign-in page" do
      get login_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Sign In")
    end
  end

  describe "users who are not signed in should be redirected to sign in" do
    it "redirects unauthenticated users away from the gallery" do
      get root_path
      expect(response).to redirect_to(login_path)
    end

    it "redirects unauthenticated users away from photo routes" do
      photo = Photo.create!(external_id: 1, url: "http://example.com", photographer: "Test",
        photographer_url: "http://example.com", image_url: "http://example.com/img.jpg", alt: "test")
      post photo_like_path(photo)
      expect(response).to redirect_to(login_path)
    end
  end

  describe "signing in with valid credentials" do
    it "grants access to the app" do
      post login_path, params: { email: "test@example.com", password: "password" }
      expect(response).to redirect_to(root_path)

      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("All Photos")
    end
  end

  describe "signing in with invalid credentials" do
    it "does not grant access" do
      post login_path, params: { email: "test@example.com", password: "wrong" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "signing out" do
    it "ends the session and redirects to sign in" do
      post login_path, params: { email: "test@example.com", password: "password" }
      delete logout_path
      expect(response).to redirect_to(login_path)

      # Confirm the user is actually signed out
      get root_path
      expect(response).to redirect_to(login_path)
    end
  end
end
