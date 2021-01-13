require 'rails_helper'

RSpec.describe "Thanks", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "shows a static message to all" do
    visit "/thanks"

    expect(page).to have_text("Thank you for requesting access.")
  end
end
