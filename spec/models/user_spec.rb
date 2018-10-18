require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }
  it { should validate_presence_of(:first_name) }
  it { should validate_length_of(:first_name).is_at_least(2).is_at_most(60) }
  it { should have_many(:loans) }

  describe 'Database Table' do
    it { is_expected.to have_db_column(:first_name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:middle_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:loans_counter).of_type(:integer).with_options(default: 0) }
  end

  describe 'user first name validations' do
    it 'validate first_name blank error' do
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'validate first name presence' do
      user.first_name = Faker::Name.first_name
      user.valid?
      expect(user.errors[:first_name]).to_not include("can't be blank")
    end

    it 'validate first_name too short' do
      user.first_name = 'S'
      user.valid?
      expect(user.errors[:first_name]).to include('is too short (minimum is 2 characters)')
    end

    it 'validate first name to long' do
      user.first_name = '123456789012345678901234567890123456789012345678901234567890123'
      user.valid?
      expect(user.errors[:first_name]).to include('is too long (maximum is 60 characters)')
    end

    it 'first name without errors' do
      user.first_name = Faker::Name.first_name
      user.valid?
      expect(user.errors[:title].empty?).to eq(true)
    end
  end

  describe 'avatar attachment process' do
    it 'valid mime type' do
      subject.avatar.attach(io: File.open("#{Dir.pwd}/spec/fixtures/first.man.jpg"), filename: 'first.man.jpg', content_type: 'image/jpg')
      expect(subject.avatar).to be_attached
    end
  end
end
