# frozen_string_literal: true

class AddStatusColumntoEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :status, :boolean
  end
end
