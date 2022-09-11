class User < ApplicationRecord

  validates_presence_of :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
