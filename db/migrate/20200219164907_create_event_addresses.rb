# frozen_string_literal: true

class CreateEventAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :event_addresses do |t|
      t.string :address_line1
      t.string :address_line2
      t.string :area
      t.string :city
      t.string :pincode
      t.timestamps
    end
  end
end
