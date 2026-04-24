require "rails_helper"

RSpec.describe "Photo gallery", type: :system, js: true do
  it "toggles a like in place without a full page reload" do
    user  = create(:user)
    photo = create(:photo)

    sign_in_as(user)
    visit photos_path

    page.execute_script("window.__reloaded = false")

    within("##{ActionView::RecordIdentifier.dom_id(photo, :like_button)}") do
      expect(page).to have_button("Like")
      click_button "Like"

      expect(page).to have_button("Unlike")
      expect(page).to have_content("1")
    end

    expect(page.evaluate_script("window.__reloaded")).to eq(false)
    expect(photo.reload.likes_count).to eq(1)
  end

  it "opens a modal when a photo is clicked" do
    user = create(:user)
    create(:photo)

    sign_in_as(user)
    visit photos_path

    find(".photo-open", match: :first).click

    expect(page).to have_css("dialog[open]")
  end
end
