require 'rails_helper'

RSpec.describe User, type: :model do
  context ".create" do

    context "validation:" do
      let(:name) {"Armand"}
      let(:email) { Faker::Internet.email }
      let(:password) { Faker::Alphanumeric.alpha(number: 6) }

      describe "with valid info" do

        it "should create a valid user" do

          user = described_class.new(name:,email:, password:)
          expect(user).to be_valid

        end

        it "should not be an admin by default" do
          user = described_class.new(name:, email:, password:)
          expect(user.admin?).to be false
        end

      end

    describe "with invalid info" do

      ['',nil,'test'].each do |invalid_email|
        it "should not create user with #{invalid_email}" do
          user = described_class.new(name:,email: invalid_email, password:)
          expect(user).to be_invalid
        end
      end
    end

  end

  end

  context "#make_admin" do
    let(:user) { create(:user) }

    describe "transforming normal user to admin" do

      it "should update admin atribute" do
        user.make_admin
        expect(user.admin?).to be true
      end

    end

  end

end
