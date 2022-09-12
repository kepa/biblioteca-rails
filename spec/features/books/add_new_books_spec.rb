require 'rails_helper'

RSpec.describe "AddNewBooks", type: :feature do

  describe "Adding new books to library:" do
    let(:user_admin) { create(:user, :admin) }
    let(:normal_user) { create(:user) }
    let(:title) {::Faker::Book.title}
    let(:author) {::Faker::Book.author}
    let(:category) {::Faker::Book.genre}

    it "should create a new book" do
      login_as(user_admin, :scope => :user)
      visit new_book_path
      fill_in 'Title', with: title
      fill_in 'Author', with: author
      fill_in 'Category', with: category
      click_on 'Create Book'
      expect(page).to have_content(title)
    end

    it "should not create a new book without permission" do
      login_as(normal_user, :scope => :user)
      visit new_book_path
      expect(current_path).to eql(root_path)
    end

  end
end
