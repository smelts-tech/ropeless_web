class AccessRequestsMailer < ApplicationMailer
  default from: 'noreply@smelts.org'

  def approved_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to the Smelts data collection system")
  end

  def rejected_email(user)
    @user = user
    mail(to: @user.email, subject: "Thanks for requesting access to Smelts")
  end
end
