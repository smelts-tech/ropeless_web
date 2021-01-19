require 'rails_helper'

RSpec.describe "Access Requests", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "requires a login" do
    visit "/access_requests"

    expect(page).to have_current_path("/users/sign_in")
  end

  it "shows a counter with the number of outstanding access requests in the header/nav" do
    login_as FactoryBot.create(:user, :active)
    2.times { FactoryBot.create(:fisher, :needs_confirmation) }

    visit "/access_requests"

    expect(page).to have_text("Access Requests 2")
  end
end
