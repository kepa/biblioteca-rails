# frozen_string_literal: true

class Rental < ApplicationRecord
  belongs_to :user

  scope :filter_by_status, ->(status) { where active: status }
  scope :filter_by_checkout, lambda { |init_date, end_date|
                               where('checkout_date >= ? and checkout_date < ?', init_date, end_date)
                             }

  before_create :init_check_out_book

  after_destroy :revert_checkout

  def init_check_out_book
    self.active = true
    self.checkout_date = Time.now
    book = Book.find(book_id)
    book.toggle_check_out
    self.book_title = book.title
  end

  def finalize
    self.active = false
    self.checkin_date = Time.now
    Book.find(book_id).toggle_check_out
  end

  def revert_checkout
    Book.find(book_id).toggle_check_out
  end

  def book
     book_title
  end
end
