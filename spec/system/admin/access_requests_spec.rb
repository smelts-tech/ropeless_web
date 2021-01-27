require 'rails_helper'

RSpec.describe "Admin > Access Requests", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "requires a login" do
    visit "/admin/access_requests"

    expect(page).to have_current_path("/users/sign_in")
  end

  it "required an admin user" do
    login_as FactoryBot.create(:fisher, :active)

    visit "/admin/access_requests"

    expect(page).to have_current_path("/")
  end

  it "shows a counter with the number of outstanding access requests in the header/nav" do
    login_as FactoryBot.create(:user, :active)
    2.times { FactoryBot.create(:fisher, :needs_confirmation) }

    visit "/admin/access_requests"

    expect(page).to have_text("Access Requests 2")
  end

  it "shows information about users who are requesting access" do
    fisher = FactoryBot.create(:fisher, :needs_confirmation)
    agency_user = FactoryBot.create(:agency_user, :needs_confirmation)
    login_as FactoryBot.create(:user, :active)

    visit "/admin/access_requests"

    expect(page).to have_text(fisher.full_name)
    expect(page).to have_text(fisher.email)
    expect(page).to have_text(fisher.permit_number)
    expect(page).to have_text(agency_user.full_name)
    expect(page).to have_text(agency_user.email)
  end

  it "lets admin users approve users for access" do
    fisher = FactoryBot.create(:fisher, :needs_confirmation)
    login_as FactoryBot.create(:user, :active)

    expect(fisher.active_for_authentication?).to be_falsey
    expect(fisher.needs_confirmation?).to be_truthy

    visit "/admin/access_requests"

    find_button("Approve").click

    fisher.reload
    expect(fisher.active_for_authentication?).to be_truthy
    expect(fisher.active?).to be_truthy
  end

  it "lets admin users reject users for access" do
    fisher = FactoryBot.create(:fisher, :needs_confirmation)
    login_as FactoryBot.create(:user, :active)
    expect(fisher.active_for_authentication?).to be_falsey

    visit "/admin/access_requests"

    find_button("Reject").click

    fisher.reload
    expect(fisher.active_for_authentication?).to be_falsey
    expect(fisher.rejected?).to be_truthy
  end

  it "sends an email when an access request is approved" do
    FactoryBot.create(:fisher, :needs_confirmation)
    login_as FactoryBot.create(:user, :active)

    visit "/admin/access_requests"

    expect { find_button("Approve").click }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it "sends an email when an access request is rejected" do
    FactoryBot.create(:fisher, :needs_confirmation)
    login_as FactoryBot.create(:user, :active)

    visit "/admin/access_requests"

    expect { find_button("Reject").click }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
