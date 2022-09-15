# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FilterBooks', type: :feature do
  describe 'Filtering by title:' do
    let(:user) { create(:user) }
    let(:title) { ::Faker::Book.title }

    before do
      Book.create(title:, category: ::Faker::Book.genre, author: ::Faker::Book.author)
    end

    it 'should filter index results' do
      login_as(user, scope: :user)
      visit root_path
      fill_in 'title', with: title
      click_on 'commit'
      expect(page).to have_content(title)
      expect(page).to have_selector('a.book-item', count: 1)
    end
  end

  describe 'Filtering by author:' do
    let(:user) { create(:user) }
    let(:author) { ::Faker::Book.author }

    before do
      2.times do
        Book.create(title: ::Faker::Book.title, category: ::Faker::Book.genre, author:)
      end
    end

    it 'should filter index results' do
      login_as(user, scope: :user)
      visit books_path
      fill_in 'By author:', with: author
      click_on 'Filter'
      expect(page).to have_content(author)
      expect(page).to have_selector('a.book-item', count: 2)
    end
  end

  describe 'Filtering by category:' do
    let(:user) { create(:user) }
    let(:category) { ::Faker::Book.genre }

    before do
      2.times do
        Book.create(title: ::Faker::Book.title, category:, author: ::Faker::Book.author)
      end
    end

    it 'should filter index results' do
      login_as(user, scope: :user)
      visit books_path
      fill_in 'By category:', with: category
      click_on 'Filter'
      expect(page).to have_content(category)
      expect(page).to have_selector('a.book-item', count: 2)
    end
  end

  describe 'Filtering by rental availability:' do
    let(:user) { create(:user) }

    before do
      2.times do
        Book.create(title: ::Faker::Book.title, category: ::Faker::Book.genre, author: ::Faker::Book.author,
                    check_out: false)
      end
    end

    it 'should filter index results' do
      login_as(user, scope: :user)
      visit books_path
      choose('status', option: 'false')
      click_on 'Filter'
      expect(page).to have_selector('a.book-item', count: 2)
    end
  end
end
