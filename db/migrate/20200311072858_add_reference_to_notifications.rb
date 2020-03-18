# frozen_string_literal: true

class AddReferenceToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :user
  end
end
