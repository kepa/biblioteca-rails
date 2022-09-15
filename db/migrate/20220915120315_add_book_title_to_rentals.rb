# frozen_string_literal: true

class AddBookTitleToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :book_title, :string
  end
end
