class WelcomeMailer < ApplicationMailer
  def signup_confirmation(user)
    @user = user
    mail to: user.email , subject: "Welcome to Eventhub" , from: 'eventhub.communication@gmail.com'
  end
end
