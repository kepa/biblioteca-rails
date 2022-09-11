class Book < ApplicationRecord
  validates_presence_of :title,:author,:category
  validates_uniqueness_of :title

  def checked_out?
    check_out
  end

  def take_out
    self.checked_out? ? errors.add(:check_out, "can't check out a book that's checked out") : self.check_out = true
  end

  def check_in
    !self.checked_out? ? errors.add(:check_out, "can't check in a book that's not checked out") : self.check_out = false
    end
end
