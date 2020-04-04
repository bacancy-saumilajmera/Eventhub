class ChangeEvents < ActiveRecord::Migration[6.0]
  def change
    change_column :events , :status , :string , default: "pending"
  end
end
