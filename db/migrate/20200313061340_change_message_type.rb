# frozen_string_literal: true

class ChangeMessageType < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :message, :text
    change_column :registered_messages, :message, :text
  end
end
