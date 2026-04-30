require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "validations" do
    let(:user) { create(:user) }
    let(:photo) { create(:photo) }

    context "when user has not liked the photo yet" do
      it "is valid" do
        like = build(:like, user: user, photo: photo)

        expect(like).to be_valid
      end
    end

    context "when the user has already liked the photo" do
      before do
        create(:like, user: user, photo: photo)
      end
      it "is invalid" do
        duplicate_like = build(:like, user: user, photo: photo)

        expect(duplicate_like).not_to be_valid
      end
    end

    context "when a different user has already liked the photo" do
      before do
        create(:like, user: create(:user), photo: photo)
      end
      it "is valid" do
        different_user = create(:user)
        like = build(:like, user: different_user, photo: photo)

        expect(like).to be_valid
      end
    end
  end

  describe "counter cache" do
    let(:user) { create(:user) }
    let(:photo) { create(:photo) }

    it "increases the photo's likes_count when a photo is liked" do
      expect {
        create(:like, user: user, photo: photo)
      }.to change { photo.reload.likes_count }.from(0).to(1)
    end

    it "decreases the photo's likes_count when a photo is unliked" do
      like = create(:like, user: user, photo: photo)
      expect {
        like.destroy
      }.to change { photo.reload.likes_count }.from(1).to(0)
    end
  end
end
