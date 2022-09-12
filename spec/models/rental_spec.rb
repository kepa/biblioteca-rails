require 'rails_helper'
require "pry"

RSpec.describe Rental, type: :model do
  context ".create" do

    context "renting a book:" do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      describe "taking out a book" do
        it "should create a new rental" do
          rental = user.rentals.create(book_id: book.id)
          book.save
          #binding.pry
          expect(rental.active).to be true
          #expect(rental.checkout_date.day).to eql(Time.now.day)
          #expect(Book.checked_out?(book.id)).to be true
        end
      end
    end

  end



end
