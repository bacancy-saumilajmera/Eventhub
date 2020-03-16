# frozen_string_literal: true

class AddColumninNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :status, :boolean
  end
end
