class AddReftoMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :event
  end
end
