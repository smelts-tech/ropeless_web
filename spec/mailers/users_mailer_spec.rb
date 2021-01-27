require "rails_helper"

RSpec.describe UsersMailer, type: :mailer do
  context "when deactivated" do
    it "renders the headers" do
      user = FactoryBot.create(:fisher, :needs_confirmation)
      mail = UsersMailer.deactivated_email(user)
      expect(mail.subject).to eq("Your account has been deactivated")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@smelts.org"])
    end

    it "renders the body" do
      user = FactoryBot.create(:fisher, :needs_confirmation)
      mail = UsersMailer.deactivated_email(user)
      expect(mail.body.encoded).to match("Your account has been deactivated")
    end
  end
end
