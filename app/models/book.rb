class Book < ApplicationRecord
  validates_presence_of :title,:author,:category
  validates_uniqueness_of :title

  def checked_out?
    #Book.find(id).check_out
    check_out
  end

  def self.checkout(id)
    Book.update(id,check_out: true)
  end

  def take_out
    self.checked_out? ? errors.add(:check_out, "can't check out a book that's checked out") : self.check_out = true
    # self.save

    # if !self.check_out?
    #   check_out = true
    #   self.save
    # else
    #   errors.add(:check_out, "can't check out a book that's checked out")
    # end

    # self.checked_out? ? errors.add(:check_out, "can't check out a book that's checked out") : update(check_out: true)
  end

  def check_in
    !self.checked_out? ? errors.add(:check_out, "can't check in a book that's not checked out") : self.check_out = false
  end

end
