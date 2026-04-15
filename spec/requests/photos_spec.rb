# spec/requests/photos_spec.rb
require "rails_helper"

RSpec.describe "Photos", type: :request do
  describe "GET /photos" do
    context "when not signed in" do
      it "redirects to sign in" do
        get photos_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      it "renders the gallery" do
        sign_in users(:user_one)
        get photos_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
