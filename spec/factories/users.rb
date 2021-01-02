FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-email#{n}@example.org" }
    password { "password" }
    password_confirmation { "password" }
  end
end
