# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateBooks', type: :feature do
  describe 'Editing books in the library:' do
    let(:user_admin) { create(:user, :admin) }
    let(:normal_user) { create(:user) }
    let(:book) { create(:book) }
    let(:title) { ::Faker::Book.title }
    let(:author) { ::Faker::Book.author }
    let(:category) { ::Faker::Book.genre }

    it 'should be able to edit title' do
      login_as(user_admin, scope: :user)
      visit edit_book_path(book)
      fill_in 'Title', with: title
      click_on 'Update Book'
      expect(page).to have_content(title)
    end

    it 'should be able to edit author' do
      login_as(user_admin, scope: :user)
      visit edit_book_path(book)
      fill_in 'Author', with: author
      click_on 'Update Book'
      expect(page).to have_content(author)
    end

    it 'should be able to edit category' do
      login_as(user_admin, scope: :user)
      visit edit_book_path(book)
      fill_in 'Category', with: category
      click_on 'Update Book'
      expect(page).to have_content(category)
    end

    it 'should not be able to edit book without permission' do
      login_as(normal_user, scope: :user)
      visit edit_book_path(book)
      expect(current_path).to eql(root_path)
    end
  end
end
