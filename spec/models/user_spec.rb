require "rails_helper"

RSpec.describe User do
  subject(:user) { build(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  describe "validations" do
    it "requires email" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "requires unique email (case-insensitive)" do
      create(:user, email: "alice@example.com")
      user.email = "ALICE@example.com"
      expect(user).not_to be_valid
    end

    it "requires valid email format" do
      user.email = "not-an-email"
      expect(user).not_to be_valid
    end

    it "requires name" do
      user.name = nil
      expect(user).not_to be_valid
    end
  end

  describe "#authenticate" do
    let!(:saved_user) { create(:user, password: "secret123") }

    it "returns the user with a correct password" do
      expect(saved_user.authenticate("secret123")).to eq(saved_user)
    end

    it "returns false with an incorrect password" do
      expect(saved_user.authenticate("wrong")).to be_falsy
    end
  end

  describe "associations" do
    it "has many likes, destroyed with user" do
      assoc = described_class.reflect_on_association(:likes)
      expect(assoc.macro).to eq(:has_many)
      expect(assoc.options[:dependent]).to eq(:destroy)
    end

    it "has many liked_photos through likes" do
      assoc = described_class.reflect_on_association(:liked_photos)
      expect(assoc.macro).to eq(:has_many)
      expect(assoc.options[:through]).to eq(:likes)
    end
  end

  it "downcases email before save" do
    user = create(:user, email: "ALICE@EXAMPLE.COM")
    expect(user.reload.email).to eq("alice@example.com")
  end
end
