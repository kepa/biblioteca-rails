require 'rails_helper'

RSpec.describe "FinalizeRental", type: :feature do

  describe "Checking in a book to the library:" do
    let(:user_admin) { create(:user, :admin) }
    let(:normal_user) { create(:user) }
    let(:book_checked_out) { create(:book, :checked_out) }
    let(:rental) { create(:rental, book_id:book_checked_out.id, user_id: normal_user.id) }

    before do
      normal_user.rentals << rental
    end

    it "should let admin finalize a rental for normal user" do
      login_as(user_admin, :scope => :user)
      visit rental_path(rental)
      click_on 'Finalize rental'

      expect(page).to have_content("Active: false")
      expect(normal_user.rentals.first.active).to be false
    end

  end
end
