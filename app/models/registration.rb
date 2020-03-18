# frozen_string_literal: true

class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates_uniqueness_of :user_id, scope: :event_id
  after_create :registration_mail, :registration_notification
  def registration_mail
    RegistrationMailer.registration_done(self).deliver
  end

  def registration_notification
    e = event_id
    event = Event.find(e)
    Notification.create(user_id: user_id, notification_message: "Thank You for Registring yourself in #{event.title}. You can Download Your Ticket from Regsitered Events Page ", status: false)
  end
end
