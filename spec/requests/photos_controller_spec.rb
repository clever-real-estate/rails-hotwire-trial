require "rails_helper"

RSpec.describe PhotosController, type: :request do
  let(:user) { create(:user) }

  describe "GET /" do
    it "returns a success response if user is logged in" do
      sign_in user
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end