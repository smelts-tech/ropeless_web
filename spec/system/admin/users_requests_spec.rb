require 'rails_helper'

RSpec.describe "Admin > Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "requires a login" do
    visit "/admin/users"

    expect(page).to have_current_path("/users/sign_in")
  end

  it "required an admin user" do
    login_as FactoryBot.create(:fisher, :active)

    visit "/admin/users"

    expect(page).to have_current_path("/dashboard")
  end

  it "shows information about users" do
    fisher = FactoryBot.create(:fisher, :active)
    agency_user = FactoryBot.create(:agency_user, :active)
    login_as FactoryBot.create(:user, :active)

    visit "/admin/users"

    expect(page).to have_text(fisher.full_name)
    expect(page).to have_text(fisher.email)
    expect(page).to have_text(fisher.permit_number)
    expect(page).to have_text(agency_user.full_name)
    expect(page).to have_text(agency_user.email)
  end

  it "lets admin users deactivate user accounts" do
    fisher = FactoryBot.create(:fisher, :active)
    login_as FactoryBot.create(:user, :active)

    visit "/admin/users"


    find_button("Deactivate").click

    fisher.reload
    expect(fisher.active_for_authentication?).to be_falsey
    expect(fisher.deactivated?).to be_truthy
  end

  it "sends an email when access is removed" do
    FactoryBot.create(:fisher, :active)
    login_as FactoryBot.create(:user, :active)

    visit "/admin/users"

    expect { find_button("Deactivate").click }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
