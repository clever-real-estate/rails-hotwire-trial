require 'rails_helper'

RSpec.describe "Photo Like Toggle", type: :system do
  let(:user) { create(:user) }
  
  before do
    login_as user, scope: :user
    # Create at least one photo for the gallery
    @photo = create(:photo, title: "Test Photo")
  end

  describe "liking a photo" do
    it "toggles like button from unliked to liked via turbo stream" do
      visit photos_path

      # Initial state: should have the like button  
      expect(page).to have_selector("button[aria-label='Like photo']")
      
      # Click to like
      find("button[aria-label='Like photo']").click
      
      # After liking: button should change to unliked
      expect(page).to have_selector("button[aria-label='Unlike photo']")
      expect(user.reload.likes.exists?(photo: @photo)).to be true
    end

    it "increments like count when photo is liked" do
      visit photos_path

      initial_count = find("[data-like-target='count']").text.to_i
      expect(initial_count).to eq(0)

      find("button[aria-label='Like photo']").click

      updated_count = find("[data-like-target='count']").text.to_i
      expect(updated_count).to eq(1)
    end
  end

  describe "unliking a photo" do
    before do
      user.likes.create!(photo: @photo)
    end

    it "toggles like button from liked to unliked via turbo stream" do
      visit photos_path

      # Initial state: should have the unlike button
      expect(page).to have_selector("button[aria-label='Unlike photo']")
      
      # Click to unlike
      find("button[aria-label='Unlike photo']").click
      
      # After unliking: button should change to like
      expect(page).to have_selector("button[aria-label='Like photo']")
      expect(user.reload.likes.exists?(photo: @photo)).to be false
    end

    it "decrements like count when photo is unliked" do
      visit photos_path

      initial_count = find("[data-like-target='count']").text.to_i
      expect(initial_count).to eq(1)

      find("button[aria-label='Unlike photo']").click

      updated_count = find("[data-like-target='count']").text.to_i
      expect(updated_count).to eq(0)
    end
  end

  describe "filter updates on like/unlike" do
    it "updates gallery when liking a photo while filtered by liked photos" do
      visit filter_photos_photos_path(filter: :liked, format: :turbo_stream)
      visit photos_path
      find("a[aria-label='Liked Photos']").click

      expect(page).to have_text("0 images available")

      find("a[aria-label='All Photos']").click
      find("button[aria-label='Like photo']").click

      find("a[aria-label='Liked Photos']").click
      expect(page).to have_text("1 image available")
      expect(page).to have_selector("img[alt='Test Photo']")
    end
  end
end
