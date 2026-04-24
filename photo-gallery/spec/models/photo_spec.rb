require "rails_helper"

RSpec.describe Photo, type: :model do
  it { is_expected.to have_many(:likes).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:photographer) }
  it { is_expected.to validate_presence_of(:src_medium) }
  it { is_expected.to validate_presence_of(:source_url) }
end
