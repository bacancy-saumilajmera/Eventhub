# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  def registration_done(record)
    @record = record
    @user = User.find(@record.user_id)
    @event = Event.find(@record.event_id)
    mail to: @user.email, subject: 'Event Details', from: 'eventhub.communication@gmail.com'
  end
end
