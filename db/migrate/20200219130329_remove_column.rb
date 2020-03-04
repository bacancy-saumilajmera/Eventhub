class RemoveColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :events , :venue ,:string
    remove_column :events , :city ,:string
  end
end
