# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create(email: "rob.sterner@gmail.com", password: "password123") # rob
User.create(email: "rgrimard@gmail.com", password: "password123") # ryan
User.create(email: "admin-user@smelts.org", password: "password123") # smelts admin


if Device.count > 0
  Fisher.destroy_all

  puts "randomizing ownership of device records..."

  Device.all.in_groups_of(5) do |devices|
    rando_fisher = Fisher.create(name: Faker::Name.name, license_number: SecureRandom.hex(10), email: Faker::Internet.email)
    devices.each do |d|
      next if d.blank?
      d.update_attributes(fisher: rando_fisher)
    end
  end
end
