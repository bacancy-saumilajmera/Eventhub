# frozen_string_literal: true

class AddReftoEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :user, index: true
  end
end
