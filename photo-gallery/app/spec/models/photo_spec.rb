require "rails_helper"
 
RSpec.describe Photo, type: :model do
  subject(:photo) { build(:photo) }
 
  describe "associations" do
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end
 
  describe "#liked_by?" do
    let(:photo) { create(:photo) }
    let(:user)  { create(:user) }
 
    context "when the user has liked the photo" do
      before { create(:like, user: user, photo: photo) }
 
      it "returns true" do
        expect(photo.liked_by?(user)).to be true
      end
    end
 
    context "when the user has not liked the photo" do
      it "returns false" do
        expect(photo.liked_by?(user)).to be false
      end
    end
 
    context "when user is nil" do
      it "returns false" do
        expect(photo.liked_by?(nil)).to be false
      end
    end
  end
end