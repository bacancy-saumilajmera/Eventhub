# frozen_string_literal: true

module EventsHelper
  def pending_notification
    @pending_notification = Notification.where(user_id: current_user.id, status: false)
    @pending_notification.count
  end
end
