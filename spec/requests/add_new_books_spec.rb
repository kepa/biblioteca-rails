require 'rails_helper'

RSpec.describe "AddNewBooks", type: :feature do
  #include Devise::Test::IntegrationHelpers

  describe "Adding new books to library:" do
    let(:user_admin) { create(:user, :admin) }


    it "should create a new book" do
      sign_in :user_admin
      visit new_book_path
      fill_in 'Title', with: ::Faker::Book.title
      fill_in 'Author', with: ::Faker::Book.author
      fill_in 'Category', with: ::Faker::Book.genre
      click_on 'Add book'
      expect(page).to have_content('Book details')
    end

  end
end
