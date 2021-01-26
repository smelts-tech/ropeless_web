require "rails_helper"

RSpec.describe AccessRequestsMailer, type: :mailer do
  context "when approved for access" do
    it "renders the headers" do
      user = FactoryBot.create(:fisher, :needs_confirmation)
      mail = AccessRequestsMailer.approved_email(user)
      expect(mail.subject).to eq("Welcome to the Smelts data collection system")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@smelts.org"])
    end

    it "renders the body" do
      user = FactoryBot.create(:fisher, :needs_confirmation)
      mail = AccessRequestsMailer.approved_email(user)
      expect(mail.body.encoded).to match("Your request for access to the Smelts ropeless web app has been approved")
    end
  end

  context "when access is rejected" do
    it "renders the headers" do
      user = FactoryBot.create(:fisher, :needs_confirmation)
      mail = AccessRequestsMailer.rejected_email(user)
      expect(mail.subject).to eq("Thanks for requesting access to Smelts")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@smelts.org"])
    end

    it "renders the body" do
      user = FactoryBot.create(:fisher, :needs_confirmation)
      mail = AccessRequestsMailer.rejected_email(user)
      expect(mail.body.encoded).to match("Your request for access to the Smelts ropeless web app has been rejected")
    end
  end
end
