require "rails_helper"
 
RSpec.describe Like, type: :model do
  subject(:like) { build(:like) }
 
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:photo) }
  end
 
  describe "validations" do
    it "prevents a user from liking the same photo twice" do
      user  = create(:user)
      photo = create(:photo)
      create(:like, user: user, photo: photo)
      duplicate = build(:like, user: user, photo: photo)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to include("has already been taken")
    end
  end
 
  describe "counter cache callbacks" do
    let(:photo) { create(:photo, likes_count: 0) }
    let(:user)  { create(:user) }
 
    it "increments photo likes_count on create" do
      expect { create(:like, user: user, photo: photo) }
        .to change { photo.reload.likes_count }.by(1)
    end
 
    it "decrements photo likes_count on destroy" do
      like = create(:like, user: user, photo: photo)
      expect { like.destroy }
        .to change { photo.reload.likes_count }.by(-1)
    end
  end
end
 