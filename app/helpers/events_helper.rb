# frozen_string_literal: true

module EventsHelper
  def pending_notification
    @pending_notification = Notification.where(user_id: current_user.id, status: false).count
  end

  def is_status_true?(arg1)
    Registration.find_by(event_id: arg1.id , user_id: current_user.id).status
  end
  
  def can_respond_requests?
    !current_user.has_role? :user
  end
end
