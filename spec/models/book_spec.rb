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

        [' ', nil].each do |invalid_title|
          it "should not create a book with empty arguments" do
            book = described_class.new(title: invalid_title,author:,category:)
            expect(book).to be_invalid
          end
        end

      end

    end

  end



end
