require "rails_helper"

RSpec.describe Like, type: :model do
  it "enforces one like per user per photo" do
    like = create(:like)
    duplicate = build(:like, user: like.user, photo: like.photo)

    expect(duplicate).not_to be_valid
    expect { duplicate.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it "increments the photo's counter cache on create and decrements on destroy" do
    photo = create(:photo)
    like = create(:like, photo: photo)

    expect(photo.reload.likes_count).to eq(1)

    like.destroy!
    expect(photo.reload.likes_count).to eq(0)
  end
end
