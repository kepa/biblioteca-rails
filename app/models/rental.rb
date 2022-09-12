#require_relative 'book'

class Rental < ApplicationRecord

  belongs_to :user

  before_create :init_check_out_book

  after_destroy :revert_checkout

  def init_check_out_book
    self.active = true
    self.checkout_date = Time.now
    Book.find(book_id).toggle_check_out
  end

  def finalize
    self.active = false
    self.checkin_date = Time.now
    Book.find(book_id).toggle_check_out
  end

  def revert_checkout
    Book.find(book_id).toggle_check_out
  end

end
