require 'rails_helper'

RSpec.describe Rental, type: :model do
  context ".create" do

    context "renting a book:" do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      describe "taking out a book" do
        it "should create a new rental" do
          rental = user.rentals.create(book_id: book.id)
          expect(rental.active).to be true
          expect(rental.checkout_date.day).to eql(Time.now.utc.day)
          expect(Book.checked_out?(book.id)).to be true
        end
      end
    end

  end

  context "#finalize" do

    describe "finalizing a rental:" do
      let(:user) { create(:user) }
      let(:book_checked_out) { create(:book, :checked_out) }
      let(:rental) { create(:rental, book_id:book_checked_out.id, user_id: user.id) }

      before do
        user.rentals << rental
      end

      it "should turn inactive a user's rental" do
        rental.finalize
        expect(user.rentals.first.active).to be false
      end

      it "should register check-in date" do
        rental.finalize
        expect(rental.checkin_date.day).to eql(Time.now.utc.day)
      end

    end

  end

  context "#destroy" do

    describe "deliting a rental record:" do
      let(:user) { create(:user) }
      let(:book_checked_out) { create(:book, :checked_out) }
      let(:rental) { create(:rental, book_id:book_checked_out.id, user_id: user.id) }

      it "should delete from user's rentals" do
        rental.destroy
        expect(user.rentals.count).to eql(0)
      end

    end

  end

end
