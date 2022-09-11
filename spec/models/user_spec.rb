require 'rails_helper'

RSpec.describe User, type: :model do
  context ".create" do

    context "validation:" do

      describe "creating user with valid info" do

        it "should create a valid user" do

          user = User.new(name: "Test", email: "test@test.com", password: "123456")
          expect(user).to be_valid

        end

        it "should not be an admin by default" do
          user = User.new(name: "Test", email: "test@test.com", password: "123456")
          expect(user.admin?).to be false
        end

      end

    end

  end
end
