require 'rails_helper'

RSpec.describe User, type: :model do
  context ".create" do

    context "validation:" do
      let(:name) {"Armand"}
      let(:email) { Faker::Internet.email }
      let(:password) { Faker::Alphanumeric.alpha(number: 6) }

      describe "creating user with valid info" do

        it "should create a valid user" do

          user = described_class.new(name:,email:, password:)
          expect(user).to be_valid

        end

        it "should not be an admin by default" do
          user = described_class.new(name:, email:, password:)
          expect(user.admin?).to be false
        end

      end

    describe "creating user with invalid info"

    end

  end
end
