# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateNewRental', type: :feature do
  describe 'Taking out a book from the library:' do
    let(:user_admin) { create(:user, :admin) }
    let(:normal_user) { create(:user) }
    let(:book) { create(:book) }
    let(:book_checked_out) { create(:book, :checked_out) }

    it 'should rent a book if normal user' do
      login_as(normal_user, scope: :user)
      visit book_path(book)
      click_on 'Take out this book'
      expect(page).to have_content('Rental #')
      expect(normal_user.rentals.count).to eql(1)
    end

    it 'should not rent a book if checked out' do
      login_as(normal_user, scope: :user)
      visit book_path(book_checked_out)
      expect(page).to_not have_content('Take out this book')
      expect(normal_user.rentals.count).to eql(0)
    end

    it 'should let admin rent a book for normal user' do
      login_as(user_admin, scope: :user)
      visit book_path(book)
      click_on 'Take out this book'
      fill_in 'User', with: normal_user.id
      fill_in 'Book', with: book.id

      click_on 'Create Rental'
      expect(page).to have_content('Rental #')
      expect(normal_user.rentals.count).to eql(1)
    end
  end
end
