require "rails_helper"

RSpec.describe Photos::LikesController, type: :request do
  let(:user) { users(:one) }
  let(:photo) { photos(:one) }

  before do
    sign_in(user)
  end

  describe "POST /create" do
    it "creates a new photo like" do
      PhotoLike.destroy_all
      expect { post photos_like_path(photo_id: photo.id, as: :turbo_stream) }.to change(PhotoLike, :count).by(1)
    end
  end

  describe "DELETE /destroy" do
    it "destroys a photo like" do
      expect { delete photos_like_path(photo_id: photo.id, as: :turbo_stream) }.to change(PhotoLike, :count).by(-1)
    end
  end
end