require 'rails_helper'

describe 'Users API' do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:api_url) { '/api/v1/' }

  describe 'GET /api/v1/users' do
    before { get "#{api_url}users" }

    it 'returns users list' do
      expect(json).not_to be_empty
      expect(json.size).to eq(users.size)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/users/:id' do
    before { get "#{api_url}users/#{user_id}" }

    context 'user exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'user does not exists' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end

    context 'loans relation' do
      let(:loan) { Loan.new }
      it 'fresh user loans_counter is 0' do
        expect(users.last.loans_counter).to eq 0
      end

      it 'loans_counter variation on loan added and removed' do
        loan.user = users.last
        loan.save
        expect(users.last.loans_counter).to eq 1
        expect(loan.user).to eq users.last
        loan.destroy
        expect(users.last.loans_counter).to eq 0
      end
    end
  end
end