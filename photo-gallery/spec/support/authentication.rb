module AuthHelpers
  def sign_in_as(user, password: "clever123")
    post session_path, params: { email_address: user.email_address, password: password }
  end
end

module SystemAuthHelpers
  def sign_in_as(user, password: "clever123")
    visit new_session_path
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: password
    click_button "Sign in"
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
  config.include SystemAuthHelpers, type: :system
end
