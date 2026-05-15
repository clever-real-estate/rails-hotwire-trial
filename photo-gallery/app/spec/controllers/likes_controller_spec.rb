require "rails_helper"
 
RSpec.describe LikesController, type: :controller do
  let(:user)  { create(:user) }
  let(:photo) { create(:photo, likes_count: 0) }
 
  before { session[:user_id] = user.id }
 
  describe "POST #create" do
    it "creates a like for the current user" do
      expect {
        post :create, params: { photo_id: photo.id }, format: :html
      }.to change(Like, :count).by(1)
    end
 
    it "increments the photo likes_count" do
      post :create, params: { photo_id: photo.id }, format: :html
      expect(photo.reload.likes_count).to eq(1)
    end
 
    it "redirects to photos_path on success" do
      post :create, params: { photo_id: photo.id }, format: :html
      expect(response).to redirect_to(photos_path)
    end
 
    context "when already liked" do
      before { create(:like, user: user, photo: photo) }
 
      it "does not create a duplicate like" do
        expect {
          post :create, params: { photo_id: photo.id }, format: :html
        }.not_to change(Like, :count)
      end
    end
  end
 
  describe "DELETE #destroy" do
    let!(:like) { create(:like, user: user, photo: photo) }
 
    it "destroys the like" do
      expect {
        delete :destroy, params: { photo_id: photo.id, id: like.id }, format: :html
      }.to change(Like, :count).by(-1)
    end
 
    it "decrements the photo likes_count" do
      photo.update!(likes_count: 1)
      delete :destroy, params: { photo_id: photo.id, id: like.id }, format: :html
      expect(photo.reload.likes_count).to eq(0)
    end
 
    it "redirects to photos_path" do
      delete :destroy, params: { photo_id: photo.id, id: like.id }, format: :html
      expect(response).to redirect_to(photos_path)
    end
  end
end