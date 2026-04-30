FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    password { "password1234" }
    password_confirmation { "password1234" }
  end
end
