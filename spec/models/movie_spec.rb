require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) {Movie.new}
  subject {FactoryBot.create(:movie)}
  # Testing model validations with shoulda gem
  it {should validate_presence_of(:title)}
  it {should validate_length_of(:title).is_at_least(2).is_at_most(250)}
  it {should validate_uniqueness_of(:title).case_insensitive}
  it {should allow_value(Date.new).for(:release_date)}
  it {should validate_inclusion_of(:classification).in_array(%w(G PG PG-13 R NC-17))}
  it {should validate_numericality_of(:duration)}
  it {should validate_numericality_of(:loan_price)}

  describe 'Database Table' do
    it {is_expected.to have_db_column(:title).of_type(:string).with_options(null: false)}
    it {should have_db_index(:title).unique(true)}
    it {is_expected.to have_db_column(:release_date).of_type(:date)}
    it {is_expected.to have_db_column(:duration).of_type(:integer).with_options(default: 1)}
    it {is_expected.to have_db_column(:country).of_type(:string).with_options(default: 'usa')}
    it {is_expected.to have_db_column(:classification).of_type(:string).with_options(default: 'G')}
    it {is_expected.to have_db_column(:imdb_code).of_type(:string)}
    it {is_expected.to have_db_column(:youtube_trailer_code).of_type(:string)}
    it {is_expected.to have_db_column(:loan_price).of_type(:decimal).with_options(precision: 4, scale: 2)}
  end

  describe 'attachment process' do
    it 'valid mime type' do
      subject.cover.attach(io: File.open("#{Dir.pwd}/spec/fixtures/first.man.jpg"), filename: 'first.man.jpg', content_type: 'image/jpg')
      expect(subject.cover).to be_attached
    end
  end

  describe 'movie loan_price validations' do
    it 'greater than 0' do
      movie.loan_price = 0
      movie.valid?
      expect(movie.errors[:loan_price]).to include('must be greater than 0')
    end

    it 'allow only numbers' do
      movie.loan_price = 'loan price'
      movie.valid?
      expect(movie.errors[:loan_price]).to include('is not a number')
    end
  end

  describe 'movie duration validations' do
    it 'greater than 0' do
      movie.duration = 0
      movie.valid?
      expect(movie.errors[:duration]).to include('must be greater than 0')
    end

    it 'be a integer number' do
      movie.duration = 2.89
      movie.valid?
      expect(movie.errors[:duration]).to include('must be an integer')
    end

    it 'allow only numbers' do
      movie.duration = 'duration'
      movie.valid?
      expect(movie.errors[:duration]).to include('is not a number')
    end
  end

  describe 'movie title validations' do
    it 'validate title blank error' do
      movie.valid?
      expect(movie.errors[:title]).to include("can't be blank")
    end

    it 'validate title presence' do
      movie.title = Faker::Movie.quote
      movie.valid?
      expect(movie.errors[:title]).to_not include("can't be blank")
    end

    it 'validate title too short' do
      movie.title = 'S'
      movie.valid?
      expect(movie.errors[:title]).to include('is too short (minimum is 2 characters)')
    end

    it 'validate title to long' do
      movie.title = '1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111'
      movie.valid?
      expect(movie.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'name without errors' do
      movie.title = 'this is a fine movie title'
      movie.valid?
      expect(movie.errors[:title].empty?).to eq(true)
    end
  end
end