require 'rails_helper'

RSpec.describe User, type: :model do
  # Requirement 1: "seed one or more users directly in db/seeds.rb"
  # Users need email + password for authentication
  it "can be created with an email and password" do
    user = User.create!(email: "demo@example.com", password: "password")
    expect(user).to be_persisted
  end

  # Requirement 1: users authenticate with email/password
  it "authenticates with the correct password" do
    user = User.create!(email: "demo@example.com", password: "password")
    expect(user.authenticate("password")).to eq user
    expect(user.authenticate("wrong")).to be_falsey
  end
end
