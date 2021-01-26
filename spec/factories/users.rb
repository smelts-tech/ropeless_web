FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    access_needed { "User" }
    sequence(:email) { |n| "test-email#{n}@example.org" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :fisher, parent: :user, class: 'Fisher' do
    permit_number { Faker::Number.number(digits: (8..10).to_a.sample) }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
    phone_number { Faker::PhoneNumber.phone_number }
    access_needed { "Fisher" }
  end

  factory :agency_user, parent: :user, class: 'AgencyUser' do
    access_needed { "AgencyUser" }
    agency_name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
