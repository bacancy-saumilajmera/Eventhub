# frozen_string_literal: true

class RegisteredMessageMailer < ApplicationMailer
  def send_message(message)
    @message = message
    @event_id = @message.event_id
    @event = Event.find(@event_id)
    @user_emails = @event.users.pluck(:email)
    mail to: @user_emails, subject: 'Event Details', from: 'eventhub.communication@gmail.com'
  end
end
