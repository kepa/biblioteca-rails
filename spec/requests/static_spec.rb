# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statics', type: :request do
  describe 'GET /home' do
    xit 'returns http success' do
      get '/static/home'
      expect(response).to have_http_status(:success)
    end
  end
end
