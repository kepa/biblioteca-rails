#require_relative 'book'

class Rental < ApplicationRecord

  belongs_to :user

  after_initialize :init_check_out_book

  def init_check_out_book
    self.active = true
    self.checkout_date = Time.now
    Book.find(book_id).toggle_check_out
  end

end
