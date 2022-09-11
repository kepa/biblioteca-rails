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

  context "#take_out" do
    let(:book) {create(:book)}
    let(:checked_out_book) {create(:book, :checked_out)}

    describe "borrowing a book:" do
      it "should check out an available book" do
        book.take_out
        expect(book.checked_out?).to be true
        expect(book).to be_valid
      end

      it "should not check out an unavailable book" do
        checked_out_book.take_out

        expect(checked_out_book.errors.count).to eql(1)
      end
    end
  end

  context "#check_in" do
    let(:book) {create(:book)}
    let(:checked_out_book) {create(:book, :checked_out)}

    describe "returning a book:" do
      it "should check in an available book" do
        checked_out_book.check_in
        expect(checked_out_book.checked_out?).to be false
        expect(checked_out_book).to be_valid
      end

      it "should not check in an unavailable book" do
        book.check_in

        expect(book.errors.count).to eql(1)
      end
    end
  end

end
