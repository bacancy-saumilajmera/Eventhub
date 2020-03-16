# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: 'Welcome to Eventhub', from: 'saumil.ajmera@bacancytechnology.com'
  end
end
