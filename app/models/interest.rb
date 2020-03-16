# frozen_string_literal: true

class Interest < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :event_id

  after_create :event_details, :interest_notification
  def event_details
    EventDetailsMailer.send_details(self).deliver
  end

  def interest_notification
    event = Event.find(event_id)
    Notification.create(user_id: user_id, notification_message: "Thank You for Showing Interest in #{event.title}. We will update you through emails and notifications", status: false)
  end
end
