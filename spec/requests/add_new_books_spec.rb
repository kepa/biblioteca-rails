require 'rails_helper'

RSpec.describe "AddNewBooks", type: :request do
  describe "GET /add_new_books" do
    it "works! (now write some real specs)" do
      get add_new_books_path
      expect(response).to have_http_status(200)
    end
  end
end
