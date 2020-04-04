# frozen_string_literal: true

class AddReftoComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :user, index: true
    add_reference :comments, :event, index: true
  end
end
