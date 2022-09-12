class Book < ApplicationRecord
  validates_presence_of :title,:author,:category
  validates_uniqueness_of :title

  def self.checked_out?(id)
    Book.find(id).check_out
  end

  def toggle_check_out
    self.check_out ^= true
    self.save
  end

end
