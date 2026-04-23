require 'rails_helper'

RSpec.describe "User login/logout", type: :request do
  describe "GET /" do
    context "when user logs in, then logs out" do
      let(:user) { create(:user) }
  
      before do
        # sign in user and navigate to /
        sign_in user
        get root_path
    
        # sign out user
        delete destroy_user_session_path
      end
      
      it "redirects to login page after logout" do
        follow_redirect!
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    context "when unauthenticated user tries to access root path" do
      it "redirects to login page" do
        get root_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
