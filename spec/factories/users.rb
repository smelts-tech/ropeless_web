FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-email#{n}@example.org" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :fisher, parent: :user, class: 'Fisher' do
    full_name { Faker::Name.name }
    permit_number { Faker::Number.number(digits: (8..10).to_a.sample) }
  end

  factory :agency_user, parent: :user, class: 'AgencyUser' do
  end
end
