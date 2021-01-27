require 'rails_helper'

RSpec.describe "Users > Passwords", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "password reset" do
    it "does not indicate if the user's email address exists in the system" do
      visit "/users/password/new"
      expect(page).to have_text("Forgot your password?")
      expect(page).to have_field("user[email]")
      email = Faker::Internet.email

      expect(User.find_by(email: email)).to be_nil
      page.fill_in("user[email]", with: email)
      find_button("Send me reset password instructions").click

      expect(page).to have_text(
        "If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes."
      )
      expect(page).to have_current_path("/users/sign_in")
    end

    it "has options to sign in or sign up" do
      visit "/users/password/new"
      expect(page).to have_text("Log in")
      expect(page).to have_text("Sign up")
    end

    it "triggers an email with a password reset link to the user" do
      user = FactoryBot.create(:fisher, status: :active)
      visit "/users/password/new"
      expect(page).to have_text("Forgot your password?")
      expect(page).to have_field("user[email]")

      page.fill_in("user[email]", with: user.email)
      expect {
        find_button("Send me reset password instructions").click
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "brings the user to a reset password screen when the link the email is clicked" do
      user = FactoryBot.create(:fisher, status: :active)
      visit "/users/password/new"
      expect(page).to have_text("Forgot your password?")
      expect(page).to have_field("user[email]")

      page.fill_in("user[email]", with: user.email)
      find_button("Send me reset password instructions").click

      link = extract_url_with_text(email: ActionMailer::Base.deliveries.first, text: "Change my password")
      visit link

      expect(page).to have_text("Change your password")
    end

    it "reset the user's password" do
      user = FactoryBot.create(:fisher, status: :active)
      visit "/users/password/new"
      expect(page).to have_text("Forgot your password?")
      expect(page).to have_field("user[email]")

      page.fill_in("user[email]", with: user.email)
      find_button("Send me reset password instructions").click

      link = extract_url_with_text(email: ActionMailer::Base.deliveries.first, text: "Change my password")
      visit link

      expect(page).to have_text("Change your password")

      page.fill_in("user[password]", with: "secret-password")
      page.fill_in("user[password_confirmation]", with: "secret-password")
      find_button("Change my password").click

      expect(page).to have_text("Your password has been changed successfully. You are now signed in.")
      expect(user.reload.valid_password?("secret-password")).to be_truthy
    end
  end
end
