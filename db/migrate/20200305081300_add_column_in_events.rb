# frozen_string_literal: true

class AddColumnInEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :price, :integer
    add_column :events, :size, :integer
  end
end
