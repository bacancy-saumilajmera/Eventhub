class AddReftoEventAddress < ActiveRecord::Migration[6.0]
  def change
    add_reference :event_addresses , :event 
  end
end
