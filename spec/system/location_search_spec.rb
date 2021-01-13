require 'rails_helper'

RSpec.describe "Location Search", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "requires a login" do
    visit "/location_search"

    expect(page).to have_current_path("/users/sign_in")
  end

  it "shows the location search page when logged in" do
    login_as FactoryBot.create(:user, :active)

    visit "/location_search?latitude=41.865099&longitude=-70.559702&radius=100"

    expect(page).to have_text("Devices")
  end

  it "shows the location search page when logged in" do
    login_as FactoryBot.create(:user, :active)
    fisher = FactoryBot.create(:fisher, :active)
    FactoryBot.create(:device, fisher: fisher, modem_id: 1, dt: '2020-10-05 15:42:27.000000', event_type: 'Set Data', geom: "0101000020E61000005F605628D2A351C0B2666490BBEE4440")

    visit "/location_search?latitude=41.865099&longitude=-70.559702&radius=100"

    expect(page).to have_text("2020-10-05 15:42:27")
  end
end
