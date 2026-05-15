require "rails_helper"
 
RSpec.describe PhotosController, type: :controller do
  let(:user)   { create(:user) }
  let!(:photos) { create_list(:photo, 3) }
 
  context "when logged in" do
    before { session[:user_id] = user.id }
 
    describe "GET #index" do
      it "assigns all photos ordered by id" do
        get :index
        expect(assigns(:photos)).to eq(Photo.all.order(:id))
      end
 
      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:ok)
      end
    end
  end
 
  context "when logged out" do
    describe "GET #index" do
      it "redirects to login" do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end
  end
end