require 'rails_helper'

RSpec.describe "Dashboards", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "requires a login" do
    visit "/dashboard"

    expect(page).to have_current_path("/users/sign_in")
  end

  it "shows the dashboard when logged in" do
    login_as FactoryBot.create(:user, :active)

    visit "/dashboard"

    expect(page).to have_text("Dashboard")
  end
end
