require 'rails_helper'

RSpec.describe "FilterBooks", type: :feature do

  describe "Filtering by author:" do
    let(:user) { create(:user) }
    let(:author) {::Faker::Book.author}
    let(:category) {::Faker::Book.genre}

    before do
      (1..2).each do
        Book.create(title: ::Faker::Book.title, category: ::Faker::Book.genre, author: author)
      end
    end

    it "should filter index results" do
      login_as(user, :scope => :user)
      visit books_path
      fill_in 'By author:', with: author
      click_on 'Filter'
      expect(page).to have_content(author)
      expect(page).to have_selector('a.book-item', count: 2)
    end

  end

  describe "Filtering by category:" do
    let(:user) { create(:user) }
    let(:category) {::Faker::Book.genre}

    before do
      (1..2).each do
        Book.create(title: ::Faker::Book.title, category: category, author: ::Faker::Book.author)
      end
    end

    it "should filter index results" do
      login_as(user, :scope => :user)
      visit books_path
      fill_in 'By category:', with: category
      click_on 'Filter'
      expect(page).to have_content(category)
      expect(page).to have_selector('a.book-item', count: 2)
    end

  end

  describe "Filtering by rental availability:" do
    let(:user) { create(:user) }

    before do
      (1..2).each do
        Book.create(title: ::Faker::Book.title, category: ::Faker::Book.genre, author: ::Faker::Book.author, check_out: false)
      end
    end

    it "should filter index results" do
      login_as(user, :scope => :user)
      visit books_path
      choose('status', option: 'false')
      click_on 'Filter'
      expect(page).to have_selector('a.book-item', count: 2)
    end

  end

end
