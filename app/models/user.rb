class User < ApplicationRecord

  validates_presence_of :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def make_admin
    self.admin = true
  end
end
