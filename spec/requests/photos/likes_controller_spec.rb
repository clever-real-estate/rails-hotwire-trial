require "rails_helper"

RSpec.describe Photos::LikesController, type: :request do
  let(:user) { create(:user) }
  let(:photo) { create(:photo) }

  before do
    sign_in user
  end

  describe "POST /create" do
    it "creates a new PhotoLike" do
      PhotoLike.destroy_all
      expect { post photos_like_path(photo_id: photo.id, as: :turbo_stream) }.to change(PhotoLike, :count).by(1)
    end
  end

  describe "DELETE /destroy" do
    it "destroys a PhotoLike" do
      create(:photo_like, user: user, photo: photo)
      expect { delete photos_like_path(photo_id: photo.id, as: :turbo_stream) }.to change(PhotoLike, :count).by(-1)
    end
  end
end