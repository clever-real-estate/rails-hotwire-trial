require 'rails_helper'

RSpec.describe "Photo Filtering", type: :system do
  let(:user) { create(:user) }
  let(:liked_photo) do
    create(:photo, title: "Liked Photo", image_url: "https://example.com/liked.jpg")
  end
  let(:unliked_photo) do
    create(:photo, title: "Unliked Photo", image_url: "https://example.com/unliked.jpg")
  end

  before do
    login_as user, scope: :user
    # Explicitly create photos by accessing the lets
    liked_photo
    unliked_photo
    user.likes.create!(photo: liked_photo)
  end

  describe "viewing photos" do
    it "displays all photos on initial page load" do
      visit photos_path

      expect(page).to have_text("Explore Photos")
      expect(page).to have_text("2 images available")
      expect(page).to have_selector("img[alt='Liked Photo']")
      expect(page).to have_selector("img[alt='Unliked Photo']")
    end

    it "shows all photos button as active by default" do
      visit photos_path

      active_button = find("a[aria-label='All Photos']")
      expect(active_button[:class]).to include("active")
    end
  end

  describe "filtering photos" do
    it "displays only liked photos when liked filter is clicked" do
      visit photos_path
      find("a[aria-label='Liked Photos']").click

      expect(page).to have_text("1 image available")
      expect(page).to have_selector("img[alt='Liked Photo']")
      expect(page).not_to have_selector("img[alt='Unliked Photo']")
      liked_button = find("a[aria-label='Liked Photos']")
      expect(liked_button[:class]).to include("active")
    end

    it "displays only not liked photos when not liked filter is clicked" do
      visit photos_path
      find("a[aria-label='Not Liked Photos']").click

      expect(page).to have_text("1 image available")
      expect(page).not_to have_selector("img[alt='Liked Photo']")
      expect(page).to have_selector("img[alt='Unliked Photo']")
    end

    it "allows toggling back to all photos view" do
      visit photos_path

      find("a[aria-label='Liked Photos']").click
      expect(page).to have_text("1 image available")

      find("a[aria-label='All Photos']").click
      expect(page).to have_text("2 images available")
      all_button = find("a[aria-label='All Photos']")
      expect(all_button[:class]).to include("active")
    end
  end

  describe "filter persistence with likes" do
    it "maintains filter preference when liking a photo" do
      visit photos_path
      find("a[aria-label='Liked Photos']").click
      expect(page).to have_text("1 image available")

      find("a[aria-label='All Photos']").click
      find("button[aria-label='Like photo']", match: :first).click

      find("a[aria-label='Liked Photos']").click
      expect(page).to have_text("2 images available")
    end
  end
end
