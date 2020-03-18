class AddColumnRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations , :status, :boolean
  end
end
