class AddCatetogyRefToEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :category, index: true
  end
end
