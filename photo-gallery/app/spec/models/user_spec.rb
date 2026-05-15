require "rails_helper"
 
RSpec.describe User, type: :model do
  subject(:user) { build(:user) }
 
  describe "associations" do
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:liked_photos).through(:likes).source(:photo) }
  end
 
  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to have_secure_password }
  end
 
  describe "#authenticate" do
    let!(:persisted) { create(:user, password: "s3cr3t!") }
 
    it "returns the user when given the correct password" do
      expect(persisted.authenticate("s3cr3t!")).to eq(persisted)
    end
 
    it "returns false for a wrong password" do
      expect(persisted.authenticate("wrong")).to be_falsey
    end
  end
end