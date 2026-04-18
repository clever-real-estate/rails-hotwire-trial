require "rails_helper"

RSpec.describe "Photos", type: :request do
  describe "GET /photos" do
    it "redirects unauthenticated visitors to sign-in" do
      get photos_path

      expect(response).to redirect_to(new_session_path)
    end

    it "renders the gallery for signed-in users" do
      user = create(:user)
      create_list(:photo, 3)
      sign_in_as(user)

      get photos_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("gallery")
    end
  end
end
