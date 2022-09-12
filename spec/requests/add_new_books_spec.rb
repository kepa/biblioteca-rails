require 'rails_helper'

RSpec.describe "AddNewBooks", type: :feature do
  describe "Adding new books to library:" do
    let(:user_admin) { create(:user, :admin) }


    it "works! (now write some real specs)" do
      visit new_book_path
      fill_in 'Title', with: ::Faker::Book.title
      fill_in 'Author', with: ::Faker::Book.author
      fill_in 'Caregory', with: ::Faker::Book.genre
      click_on 'Add book'
      expect(current_path).to eql(books_path)
    end

  end
end
