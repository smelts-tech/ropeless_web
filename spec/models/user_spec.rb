require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "requires an email address, password, and password_confirmation" do
      fisher = FactoryBot.build(:fisher, email: nil, password: nil, password_confirmation: nil)
      expect(fisher).to_not be_valid
      expect(fisher.errors.keys).to eql(%i(email password))
    end
  end
end
