require 'rails_helper'

RSpec.describe "DestroyRental", type: :feature do

  describe "Destroying a rental record:" do
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
      click_on 'Destroy rental'

      expect(current_path).to eql(root_path)
      expect(normal_user.rentals.count).to eql(0)
      #expect(Book.checked_out?(book_checked_out.id)).to be false
    end

  end
end
