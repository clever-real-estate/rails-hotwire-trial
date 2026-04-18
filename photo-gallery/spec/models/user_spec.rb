require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:sessions).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:liked_photos).through(:likes).source(:photo) }
end
