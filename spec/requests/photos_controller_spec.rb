require "rails_helper"

RSpec.describe PhotosController, type: :request do
  let(:user) { users(:one) }

  describe "GET /index" do
    it "redirects to the login page if the user is not logged in" do
      get photos_path
      expect(response).to redirect_to(new_session_path)
    end

    it "returns a success response if the user is logged in" do
      sign_in(user)
      get photos_path
      expect(response).to be_successful
    end
  end
end