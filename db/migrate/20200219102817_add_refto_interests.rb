# frozen_string_literal: true

class AddReftoInterests < ActiveRecord::Migration[6.0]
  def change
    add_reference :interests, :user
    add_reference :interests, :event
  end
end
