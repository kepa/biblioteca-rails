require 'rails_helper'

RSpec.describe "DestroyBooks", type: :feature do

  describe "Destroy books in the library:" do
    let(:user_admin) { create(:user, :admin) }
    let(:normal_user) { create(:user) }
    let(:book) { create(:book) }


    it "should be able to delete a book" do
      login_as(user_admin, :scope => :user)
      visit book_path(book)
      click_on 'Delete book'
      expect(current_path).to eql(root_path)
    end

    xit "should not be able to delete a book without permission" do
      login_as(normal_user, :scope => :user)
      visit book_path(book)
      click_on 'Delete book'
      expect(current_path).to eql(book_path(book))
    end

  end
end
