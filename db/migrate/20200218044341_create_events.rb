# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :date
      t.time :time
      t.string :venue
      t.string :city
      t.string :website
      t.timestamps
    end
  end
end
