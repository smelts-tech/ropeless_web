FactoryBot.define do
  factory :fisher do
    name { Faker::Name.name }
    sequence(:email) { |n| "test-email#{n}@example.org" }
    license_number { SecureRandom.hex(10) }
  end

end
