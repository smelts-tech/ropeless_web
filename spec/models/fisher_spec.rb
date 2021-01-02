require 'rails_helper'

RSpec.describe Fisher, type: :model do
  context "validations" do
    it "requires a name and permit number" do
      fisher = FactoryBot.build(:fisher, full_name: nil, permit_number: nil)
      expect(fisher).to_not be_valid
      expect(fisher.errors.keys).to eql(%i(full_name permit_number))
    end
  end
end
