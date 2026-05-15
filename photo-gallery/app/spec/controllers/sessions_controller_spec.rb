require "rails_helper"
 
RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user, email: "test@example.com", password: "password") }
 
  describe "GET #new" do
    context "when not logged in" do
      it "renders the login form" do
        get :new
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:ok)
      end
    end
 
    context "when already logged in" do
      before { session[:user_id] = user.id }
 
      it "redirects to root" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end
 
  describe "POST #create" do
    context "with valid credentials" do
      it "sets the session user_id and redirects to root" do
        post :create, params: { email: user.email, password: "password" }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(root_path)
      end
    end
 
    context "with invalid password" do
      it "re-renders the login form with 422" do
        post :create, params: { email: user.email, password: "wrong" }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
 
    context "with unknown email" do
      it "re-renders the login form" do
        post :create, params: { email: "nobody@example.com", password: "password" }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:new)
      end
    end
  end
 
  describe "DELETE #destroy" do
    before { session[:user_id] = user.id }
 
    it "clears the session and redirects to login" do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
    end
  end
end