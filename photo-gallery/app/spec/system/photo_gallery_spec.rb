require "rails_helper"
 
RSpec.describe "Photo Gallery", type: :system do
  let!(:user)   { create(:user, email: "demo@example.com", password: "password") }
  let!(:photos) { create_list(:photo, 4) }
 
  before do
    driven_by(:rack_test)
    visit login_path
    fill_in "Email",    with: "demo@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"
  end
 
  it "displays all photos on the gallery page" do
    visit root_path
    photos.each do |photo|
      expect(page).to have_css("#photo-#{photo.id}")
    end
  end
 
  it "shows the photo count badge" do
    visit root_path
    expect(page).to have_css(".gallery-count")
  end
 
  describe "liking a photo" do
    let(:photo) { photos.first }
 
    it "increments the like count" do
      visit root_path
      within "#photo-#{photo.id}" do
        expect(page).to have_css(".like-count", text: "0")
        click_button "Like photo"
        # After turbo stream / redirect, count should be 1
      end
      expect(photo.reload.likes_count).to eq(1)
    end
 
    it "prevents liking the same photo twice" do
      visit root_path
      within "#photo-#{photo.id}" do
        click_button "Like photo"
      end
      visit root_path
      expect(Like.where(user: user, photo: photo).count).to eq(1)
    end
  end
 
  describe "unliking a photo" do
    let(:photo) { photos.first }
    let!(:like) { create(:like, user: user, photo: photo) }
 
    before { photo.update!(likes_count: 1) }
 
    it "decrements the like count" do
      visit root_path
      within "#photo-#{photo.id}" do
        click_button "Unlike photo"
      end
      expect(photo.reload.likes_count).to eq(0)
    end
  end
end