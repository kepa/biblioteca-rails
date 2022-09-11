class Book < ApplicationRecord
  validates_presence_of :title,:author,:category
end
