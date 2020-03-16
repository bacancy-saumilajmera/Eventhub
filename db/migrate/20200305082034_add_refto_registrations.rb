# frozen_string_literal: true

class AddReftoRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_reference :registrations, :user
    add_reference :registrations, :event
  end
end
