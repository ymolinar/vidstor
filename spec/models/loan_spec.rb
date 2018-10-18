require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { Loan.create }
  let!(:movies) { create_list(:movie, Faker::Number.between(1, 10)) }
  let(:user) { create(:user) }

  it { should belong_to(:user) }
  it { should allow_value(DateTime.new).for(:expire_at) }
  it { should have_and_belong_to_many(:movies) }

  describe 'Database Table' do
    it { is_expected.to have_db_column(:expire_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'related movies' do
    it 'new loan movies should be empty' do
      expect(loan.movies.empty?).to eq true
    end

    it 'new loan movies size should 0' do
      expect(loan.movies.size).to eq 0
    end

    context 'with movies added' do
      before 'add some fake movies' do
        loan.movies << movies
        loan.user = user
        loan.save
      end

      it 'movies should be not empty' do
        expect(loan.movies.empty?).to eq false
      end

      it 'movies size should different from 0 and equal to max' do
        expect(loan.movies.size).to_not eq 0
        expect(loan.movies.size).to eq movies.size
      end

      it 'expire date must be now plus n days based on movies count' do
        expect(loan.expire_at).to eq(DateTime.now.beginning_of_day + movies.size.days)
      end

      it 'loan owner loans_counter equal 1' do
        expect(user.loans_counter).to eq 1
      end

      it 'any movie should have one loan associated' do
        expect(movies[0].loans.size).to eq 1
      end
    end
  end
end
