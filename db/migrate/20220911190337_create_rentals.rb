class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.boolean :active
      t.boolean :late
      t.datetime :checkout_date
      t.datetime :checkin_date

      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
