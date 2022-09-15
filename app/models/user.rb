# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rentals

  def make_admin
    self.admin = true
  end
end
