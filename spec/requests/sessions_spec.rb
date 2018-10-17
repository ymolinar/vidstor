# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('POST /auth/login', type: :request) do
  let(:base_url) { '/auth' }
  let(:user) { create(:user) }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'params are correct' do
    before do
      post "#{base_url}/login", params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end
  end

  context 'params are incorrect' do
    before { post "#{base_url}/login", params: { user: { email: user.email, password: 'wrong' } } }

    it 'returns unauthorized status' do
      expect(response.status).to eq 401
    end
  end
end
