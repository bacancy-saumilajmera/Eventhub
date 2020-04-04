# frozen_string_literal: true

class AddColumninCtegories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :category_name, :string
  end
end
