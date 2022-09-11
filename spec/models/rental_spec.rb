require 'rails_helper'

RSpec.describe Rental, type: :model do
  context ".create" do

    context "renting a book:" do
      let(:user) { create(:user) }

      describe "taking out a book" do
        it "should create a new rental" do
          rental = user.rentals.create
          expect(rental.active).to be true
          expect(rental.checkout_date.day).to eql(Time.now.day)
          expect(rental).to be_valid
        end
      end
    end

  end



end
