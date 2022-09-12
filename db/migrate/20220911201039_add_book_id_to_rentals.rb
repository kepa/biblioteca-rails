class AddBookIdToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :book_id, :integer
  end
end
