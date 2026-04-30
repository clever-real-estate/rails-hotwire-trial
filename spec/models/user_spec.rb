require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validity" do
    context "with email and password" do
      it "is valid" do
        user = build(:user)

        expect(user).to be_valid
      end
    end
  end
end
