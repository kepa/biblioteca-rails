# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FilterRentals', type: :feature do
  context 'Rental Filters - ' do
    let(:normal_user) { create(:user) }
    let(:admin_user) { create(:user, :admin) }
    let(:book) { create(:book) }

    before do
      5.times do
        Rental.create(user_id: normal_user.id, book_id: book.id)
      end

      Rental.first.update!(checkout_date: Time.now - 3.days)
      Rental.second.update!(checkout_date: Time.now - 2.days)
    end

    describe 'Filtering by rental status:' do
      it 'should filter rentals#index results' do
        login_as(normal_user, scope: :user)
        visit rentals_path
        choose('status', option: 'true')
        click_on 'Filter'
        expect(page).to have_selector('a.book-item', count: 5)
      end
    end

    describe 'Filtering by checkout date:' do
      it 'should filter rentals#index results' do
        login_as(normal_user, scope: :user)
        visit rentals_path
        fill_in 'checkout_date_init', with: (DateTime.current - 4.days).strftime('%Y-%m-%d')
        fill_in 'checkout_date_end', with: (DateTime.current - 1.days).strftime('%Y-%m-%d')
        click_on 'Filter'
        expect(page).to have_selector('a.book-item', count: 2)
      end
    end
  end
end
