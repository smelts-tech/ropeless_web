class UsersMailer < ApplicationMailer
  default from: 'noreply@smelts.org'

  def deactivated_email(user)
    @user = user
    mail(to: @user.email, subject: "Your account has been deactivated")
  end
end
