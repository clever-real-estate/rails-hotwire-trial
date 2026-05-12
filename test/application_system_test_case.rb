require "test_helper"

# Force Selenium Manager to manage chromedriver itself, ignoring any stale
# chromedriver that happens to be on PATH.
Selenium::WebDriver::Chrome::Service.driver_path = nil

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  def sign_in_as(user, password: "password")
    visit sign_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_on "Sign in"
    assert_text "All Photos"
  end
end
