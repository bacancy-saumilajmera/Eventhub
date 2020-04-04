# frozen_string_literal: true

class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.integer :quantity
      t.integer :total_amount
      t.timestamps
    end
  end
end
