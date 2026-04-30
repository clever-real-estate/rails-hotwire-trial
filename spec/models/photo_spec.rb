require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe "#liked_by?" do
    context "when user has liked the photo" do
      it "returns true" do
        user = create(:user)
        photo = create(:photo)
        create(:like, user: user, photo: photo)

        expect(photo.liked_by?(user)).to be true
      end
    end

    context "when user has not liked the photo" do
      it "returns false" do
        user = create(:user)
        photo = create(:photo)

        expect(photo.liked_by?(user)).to be false
      end
    end
  end
end
