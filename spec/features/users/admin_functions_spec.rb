# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminFunctions', type: :feature do
  describe 'Editing users:' do
    let(:admin_user) { create(:user, :admin) }
    let(:normal_user) { create(:user) }


    it 'should only let admin view all users' do
      login_as(normal_user, scope: :user)
      visit users_path

      expect(current_path).to eql(root_path)
    end

    it 'should let current user edit their profile' do
      login_as(normal_user, scope: :user)
      visit user_path(normal_user)
      click_on 'Edit profile'

      expect(page).to have_content("Editing #{normal_user.name}")
    end

    it 'should let admin user edit any profile' do
      login_as(admin_user, scope: :user)
      visit user_path(normal_user)
      click_on 'Edit profile'

      expect(page).to have_content("Editing #{normal_user.name}")
    end

    it 'should let admin user edit any profile atribute' do
      login_as(admin_user, scope: :user)
      visit user_path(normal_user)
      click_on 'Edit profile'
      fill_in 'Name', with: "test"
      click_on 'Update'

      expect(page).to have_content("test")
    end

    it 'should let admin user make users admin' do
      login_as(admin_user, scope: :user)
      visit user_path(normal_user)
      click_on 'Edit profile'

      expect(page).to have_content("Set admin privaliges?")
    end

  end

  describe "Deleting users" do
    let(:admin_user) { create(:user, :admin) }
    let(:normal_user) { create(:user) }

    it 'should let admins delete any user' do
      login_as(admin_user, scope: :user)
      visit user_path(normal_user)
      click_on 'Delete user'

      expect(current_path).to eql(users_path)
    end

  end

end
