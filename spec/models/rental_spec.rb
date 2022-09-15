# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rental, type: :model do
  context '.create' do
    context 'renting a book:' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      describe 'taking out a book' do
        it 'should create a new rental' do
          rental = user.rentals.create(book_id: book.id)
          expect(rental.active).to be true
          expect(rental.checkout_date.day).to eql(Time.now.utc.day)
          expect(Book.checked_out?(book.id)).to be true
        end
      end
    end
  end

  context '#finalize' do
    describe 'finalizing a rental:' do
      let(:user) { create(:user) }
      let(:book_checked_out) { create(:book, :checked_out) }
      let(:rental) { create(:rental, book_id: book_checked_out.id, user_id: user.id) }

      before do
        user.rentals << rental
      end

      it "should turn inactive a user's rental" do
        rental.finalize
        expect(user.rentals.first.active).to be false
      end

      it 'should register check-in date' do
        rental.finalize
        expect(rental.checkin_date.day).to eql(Time.now.utc.day)
      end
    end
  end

  context '#destroy' do
    describe 'deliting a rental record:' do
      let(:user) { create(:user) }
      let(:book_checked_out) { create(:book, :checked_out) }
      let(:rental) { create(:rental, book_id: book_checked_out.id, user_id: user.id) }

      it "should delete from user's rentals" do
        rental.destroy
        expect(user.rentals.count).to eql(0)
      end
    end
  end

  context '#filter_by_status' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    before do
      2.times do
        Rental.create(user_id: user.id, book_id: book.id)
      end
    end

    describe 'select rentals by status:' do
      it 'should return active rentals' do
        result = Rental.filter_by_status(true)
        expect(result.count).to eql(2)
      end
    end
  end

  context '#filter_by_checkout' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    before do
      5.times do
        Rental.create(user_id: user.id, book_id: book.id)
      end

      Rental.first.update!(checkout_date: Time.now - 3.days)
      Rental.second.update!(checkout_date: Time.now - 2.days)
    end

    describe 'select rentals by checkout date:' do
      it 'should return a rental by specific date' do
        result = Rental.filter_by_checkout(Time.now - 4.days, Time.now - 1.days)
        expect(result.count).to eql(2)
      end
    end
  end

  context '#book' do
    describe 'listing book that is rented:' do
      let(:book) { create(:book) }
      let(:user) { create(:user) }
      let(:rental) { Rental.create(book_id: book.id, user_id: user.id) }

      it 'should return the name of the rented book' do
        expect(rental.book).to eql(book.title)
      end
    end
  end
end
