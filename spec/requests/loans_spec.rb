require 'rails_helper'

describe 'Loans API' do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let!(:loans) { create_list(:loan, 10, user_id: user.id) }
  let(:id) { loans.first.id }
  let(:api_url) { '/api/v1/' }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/users/:user_id/loans' do
    before { get "#{api_url}users/#{user_id}/loans", headers: headers }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns user loans' do
        expect(json.size).to eq loans.size
      end
    end

    context 'when user does not exists' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'GET /api/v1/users/:user_id/loans' do
    before { get "#{api_url}/users/#{user_id}/loans/#{id}", headers: headers }

    context 'when user loan exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the loan' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user loan does not exists' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Loan/)
      end
    end
  end
end