class Rental < ApplicationRecord

  belongs_to :user

  after_initialize :init_check_out_book

  def init_check_out_book
    self.active = true
    self.checkout_date = Time.now
    Book.checkout(book_id)
  end

end
