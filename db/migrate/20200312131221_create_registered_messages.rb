# frozen_string_literal: true

class CreateRegisteredMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_messages do |t|
      t.belongs_to :event
      t.string :message
      t.timestamps
    end
  end
end
