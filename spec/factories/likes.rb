FactoryBot.define do
  factory :like do
    user { create(:user) }
    photo { create(:photo) }
  end
end
