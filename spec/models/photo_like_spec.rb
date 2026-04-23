require "rails_helper"

RSpec.describe PhotoLike, type: :model do
  let(:user) { create(:user) }
  let(:photo) { create(:photo) }

  it "belongs_to user" do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it "belongs_to photo" do
    association = described_class.reflect_on_association(:photo)
    expect(association.macro).to eq(:belongs_to)
  end

  it "is unique per user and photo" do
    photo_like = PhotoLike.create!(user: user, photo: photo)
    dup_photo_like = PhotoLike.new(user: user, photo: photo)
    expect(photo_like).to be_valid
    expect(dup_photo_like).not_to be_valid
    expect(dup_photo_like.errors.full_messages).to include("User has already liked this photo.")
  end
end