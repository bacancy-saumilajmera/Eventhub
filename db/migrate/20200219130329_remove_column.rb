class RemoveColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :events , :venue
    remove_column :events , :city
  end
end
