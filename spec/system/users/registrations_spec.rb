require 'rails_helper'

RSpec.describe "Users > Registrations", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "shows the expected form fields for agency users" do
    visit "/users/sign_up"
    expect(page).to have_text("Request access")

    # form fields
    expect(page).to have_field("user[full_name]")
    expect(page).to have_field("user[email]")
    expect(page).to have_field("user[password]")
    expect(page).to have_field("user[password_confirmation]")
    expect(page).to have_field("user[address]")
    expect(page).to have_field("user[city]")
    expect(page).to have_field("user[state]")
    expect(page).to have_field("user[zip_code]")
    expect(page).to have_field("user[phone_number]")
    expect(page).to have_button("Sign up")

    # choose agency user
    find_field("user[access_needed]").find(:option, "Agency User").select_option
    expect(page).to have_text("This is for users from federal agencies")
    expect(page).to have_field("user[agency_name]")
    expect(page).to_not have_field("user[permit_number]")
  end

  it "shows the expected form fields for fishers" do
    visit "/users/sign_up"
    expect(page).to have_text("Request access")

    # form fields
    expect(page).to have_field("user[full_name]")
    expect(page).to have_field("user[email]")
    expect(page).to have_field("user[password]")
    expect(page).to have_field("user[password_confirmation]")
    expect(page).to have_field("user[address]")
    expect(page).to have_field("user[city]")
    expect(page).to have_field("user[state]")
    expect(page).to have_field("user[zip_code]")
    expect(page).to have_field("user[phone_number]")
    expect(page).to have_button("Sign up")

    # choose fisher
    find_field("user[access_needed]").find(:option, "Fisher").select_option
    expect(page).to have_text("As a Fisher, you will be able to upload data")
    expect(page).to have_field("user[permit_number]")
    expect(page).to_not have_field("user[agency_name]")
  end

  it "has links to go elsewhere to log in, reset password, etc." do
    visit "/users/sign_up"
    expect(page).to have_text("Log in") # for people with accounts
  end

  it "shows common errors if no access needed is selected" do
    visit "/users/sign_up"
    find_button("Sign up").click

    expect(page).to have_text("There are 4 errors with the information you provided:")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Password can't be blank")
    expect(page).to have_text("Full name can't be blank")
    expect(page).to have_text("Access needed can't be blank")

    expect(page.all(:css, '.form-group.errored').count).to equal(4)
  end

  it "shows Fisher validation messages inline and at the top of the form" do
    visit "/users/sign_up"
    find_field("user[access_needed]").find(:option, "Fisher").select_option
    find_button("Sign up").click

    expect(page).to have_text("There are 9 errors with the information you provided:")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Password can't be blank")
    expect(page).to have_text("Full name can't be blank")
    expect(page).to have_text("Permit number can't be blank")
    expect(page).to have_text("Address can't be blank")
    expect(page).to have_text("City can't be blank")
    expect(page).to have_text("State can't be blank")
    expect(page).to have_text("Zip code can't be blank")
    expect(page).to have_text("Phone number can't be blank")

    expect(page.all(:css, '.form-group.errored').count).to equal(9)
  end

  it "shows Agency User validation messages inline and at the top of the form" do
    visit "/users/sign_up"
    # set agency user
    find_field("user[access_needed]").find(:option, "Agency User").select_option
    find_button("Sign up").click

    expect(page).to have_text("There are 9 errors with the information you provided:")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Password can't be blank")
    expect(page).to have_text("Full name can't be blank")
    expect(page).to have_text("Agency name can't be blank")
    expect(page).to have_text("Address can't be blank")
    expect(page).to have_text("City can't be blank")
    expect(page).to have_text("State can't be blank")
    expect(page).to have_text("Zip code can't be blank")
    expect(page).to have_text("Phone number can't be blank")

    expect(page.all(:css, '.form-group.errored').count).to equal(9)
  end

  it "creates a new Fisher whose status is `needs_confirmation`" do
    visit "/users/sign_up"
    find_field("user[access_needed]").find(:option, "Fisher").select_option

    page.fill_in("user[full_name]", with: Faker::Name.name)
    page.fill_in("user[permit_number]", with: SecureRandom.hex(10))
    page.fill_in("user[address]", with: Faker::Address.street_address)
    page.fill_in("user[city]", with: Faker::Address.city)
    page.fill_in("user[state]", with: Faker::Address.state_abbr)
    page.fill_in("user[zip_code]", with: Faker::Address.zip_code)
    page.fill_in("user[phone_number]", with: Faker::PhoneNumber.phone_number)
    page.fill_in("user[email]", with: Faker::Internet.email)
    page.fill_in("user[password]", with: "password")
    page.fill_in("user[password_confirmation]", with: "password")

    find_button("Sign up").click

    expect(page).to have_current_path('/thanks')
  end

  it "creates a new Agency User whose status is `needs_confirmation`" do
    visit "/users/sign_up"
    find_field("user[access_needed]").find(:option, "Agency User").select_option

    page.fill_in("user[full_name]", with: Faker::Name.name)
    page.fill_in("user[agency_name]", with: Faker::Company.name)
    page.fill_in("user[address]", with: Faker::Address.street_address)
    page.fill_in("user[city]", with: Faker::Address.city)
    page.fill_in("user[state]", with: Faker::Address.state_abbr)
    page.fill_in("user[zip_code]", with: Faker::Address.zip_code)
    page.fill_in("user[phone_number]", with: Faker::PhoneNumber.phone_number)
    page.fill_in("user[email]", with: Faker::Internet.email)
    page.fill_in("user[password]", with: "password")
    page.fill_in("user[password_confirmation]", with: "password")

    find_button("Sign up").click

    expect(page).to have_current_path('/thanks')
  end
end
