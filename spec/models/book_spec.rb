require 'rails_helper'

RSpec.describe Book, type: :model do
  context ".create" do

    context "validation:" do
      let(:title) { Faker::Book.title }
      let(:author) { Faker::Book.author }
      let(:category) { Faker::Book.genre }

      describe "with valid info" do

        it "should create a valid book" do
          book = described_class.new(title:,author:,category:)
          expect(book).to be_valid
        end

      end

      describe "with invalid info" do

        [' ', nil, ''].each do |invalid_title|
          it "should not create a book with empty arguments" do
            book = described_class.new(title: invalid_title,author:,category:)
            expect(book).to be_invalid
          end
        end

      end

    end

  end

  context "#toggle_check_out" do
    let(:book) { create(:book) }
    let(:borowed_book) { create(:book, :checked_out)}

    describe "borrowing a book:" do
      it "should checkout a book" do
        book.toggle_check_out
        expect(Book.checked_out?(book.id)).to be true
      end
    end

    describe "returning a book" do
      it "should return a book" do
        borowed_book.toggle_check_out
        expect(Book.checked_out?(borowed_book.id)).to be false
      end
    end

  end

  context "#filter_by_title" do

    describe "select books by title:" do
      let(:title) {::Faker::Book.title}

      before do

        Book.create(title: title, category: ::Faker::Book.genre, author: ::Faker::Book.author)

      end

      it "should return books with same title" do
        result = Book.filter_by_title(title)
        expect(result.count).to eql(1)
      end

      it "should not return books with non existant title" do
        result = Book.filter_by_title("test")
        expect(result.count).to eql(0)
      end

    end

  end

  context "#filter_by_author" do

    describe "select books by author:" do
      let(:author) {::Faker::Book.author}

      before do
        (1..2).each do
          Book.create(title: ::Faker::Book.title, category: ::Faker::Book.genre, author: author)
        end
      end

      it "should return books by the same author" do
        result = Book.filter_by_author(author)
        expect(result.count).to eql(2)
      end

      it "should not return books by non existant author" do
        result = Book.filter_by_author("test")
        expect(result.count).to eql(0)
      end

    end

  end

  context "#filter_by_category" do
    let(:category) {::Faker::Book.genre}

    before do
      (1..2).each do
        Book.create(title: ::Faker::Book.title, category: category, author: ::Faker::Book.author)
      end
    end

    describe "select books by category:" do

      it "should return books by the same category" do
        result = Book.filter_by_category(category)
        expect(result.count).to eql(2)
      end

    end

  end

  context "#filter_by_status" do

    before do
      (1..2).each do
        Book.create(title: ::Faker::Book.title, category: ::Faker::Book.genre, author: ::Faker::Book.author, check_out: false)
      end
    end

    describe "select books by status:" do

      it "should return books by status" do
        result = Book.filter_by_status(false)
        expect(result.count).to eql(2)
      end

    end

  end

end
