class UserTableUpdate < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :username
    remove_column :users, :contact_no
  end
end
