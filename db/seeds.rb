# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create!(email: "rob.sterner@gmail.com", full_name: "Rob Sterner", password: "password123", status: :active, access_needed: "User") # rob
User.create!(email: "rgrimard@gmail.com", full_name: "Ryan Grimard", password: "password123", status: :active, access_needed: "User") # ryan
User.create!(email: "admin-user@smelts.org", full_name: "Smelts Admin", password: "password123", status: :active, access_needed: "User") # smelts admin


if Device.count > 0
  Fisher.destroy_all

  puts "randomizing ownership of device records..."

  Device.all.in_groups_of(5) do |devices|
    rando_fisher = Fisher.create! \
      full_name: Faker::Name.name,
      permit_number: SecureRandom.hex(10),
      email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password"

    devices.each do |d|
      next if d.blank?
      d.update_attributes(fisher: rando_fisher)
    end
  end
end
