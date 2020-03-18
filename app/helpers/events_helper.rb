# frozen_string_literal: true

module EventsHelper
  def pending_notification
    @pending_notification = Notification.where(user_id: current_user.id, status: false).count
  end

  def is_status_true?(arg1)
    @arg = arg1[0]
    @registered_event = Registration.where(event_id: @arg.id , user_id: current_user.id).first.status
  end

end
