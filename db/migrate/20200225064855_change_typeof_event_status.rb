# frozen_string_literal: true

class ChangeTypeofEventStatus < ActiveRecord::Migration[6.0]
  def up
    change_column :events, :status, :string
  end

  def down
    change_column :events, :status, :boolean
  end
end
