# frozen_string_literal: true

class CreateInterests < ActiveRecord::Migration[6.0]
  def change
    create_table :interests, &:timestamps
  end
end
