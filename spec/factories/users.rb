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
    access_needed { "Fisher" }
  end

  factory :agency_user, parent: :user, class: 'AgencyUser' do
    access_needed { "AgencyUser" }
    agency_name { Faker::Company.name }
  end
end
