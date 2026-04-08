require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { users(:one) }
  it "requires a unique username" do
    duplicate_user = User.new(username: user.username, password: "password")
    expect(duplicate_user).not_to be_valid
    expect(duplicate_user.errors.full_messages).to include("Username has already been taken")
  end

  it "requires a username" do
    user.username = nil
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include("Username can't be blank")
  end
end
