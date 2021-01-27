# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create!(email: "smelts-admin@smelts.org", full_name: "Smelts Admin", password: "acraftypassword", status: :active, access_needed: "User") # rob

if Device.count > 0
  Fisher.destroy_all

  puts "randomizing ownership of device records..."

  Device.all.in_groups_of(5) do |devices|
    rando_fisher = Fisher.create! \
      full_name: Faker::Name.name,
      permit_number: SecureRandom.hex(10),
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zip_code: Faker::Address.zip_code,
      phone_number: Faker::PhoneNumber.phone_number,
      email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password"

    devices.each do |d|
      next if d.blank?
      d.update_attributes(fisher: rando_fisher)
    end
  end
end
