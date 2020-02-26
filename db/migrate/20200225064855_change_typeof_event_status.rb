class ChangeTypeofEventStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :status, :string
  end
end
