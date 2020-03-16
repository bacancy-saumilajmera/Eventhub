# frozen_string_literal: true

class NotificationsController < ApplicationController
  def show_notifications
    @notification = Notification.where(user_id: current_user.id).order(created_at: :desc)
    Notification.where(user_id: current_user.id, status: false).update(status: true)
  end
end
