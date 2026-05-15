require "rails_helper"
 
RSpec.describe "Authentication", type: :system do
  let!(:user) { create(:user, email: "demo@example.com", password: "password") }
 
  before { driven_by(:rack_test) }
 
  describe "sign in" do
    it "allows a user to sign in with correct credentials" do
      visit login_path
      fill_in "Email",    with: "demo@example.com"
      fill_in "Password", with: "password"
      click_button "Sign In"
 
      expect(page).to have_current_path(root_path)
      expect(page).to have_text("demo@example.com")
    end
 
    it "shows an error for invalid credentials" do
      visit login_path
      fill_in "Email",    with: "demo@example.com"
      fill_in "Password", with: "wrongpassword"
      click_button "Sign In"
 
      expect(page).to have_current_path(login_path)
      expect(page).to have_text("Invalid email or password")
    end
 
    it "redirects unauthenticated users to login" do
      visit root_path
      expect(page).to have_current_path(login_path)
    end
  end
 
  describe "sign out" do
    before do
      visit login_path
      fill_in "Email",    with: "demo@example.com"
      fill_in "Password", with: "password"
      click_button "Sign In"
    end
 
    it "signs the user out and redirects to login" do
      click_button "Sign out"
      expect(page).to have_current_path(login_path)
    end
  end
end