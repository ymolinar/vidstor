require 'rails_helper'

RSpec.describe 'Movies API' do
  let!(:movie_list) {create_list(:movie, 10)}
  let(:movie_id) {movie_list.first.id}
  let(:api_url) {'/api/v1/'}

  describe 'GET /api/v1/movies' do
    before {get "#{api_url}movies"}
    it 'returns movies' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/movies/:id' do
    before {get "#{api_url}movies/#{movie_id}"}
    context 'movie exists' do
      it 'returns the movie object' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(movie_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'movie does not exist' do
      let(:movie_id) {100}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Movie/)
      end
    end
  end

  describe 'POST /movies' do
    let(:request_attributes) {{title: 'This is a new film', release_date: '2018-10-14'}}

    context 'when everything is fine' do
      before {post "#{api_url}movies", params: request_attributes}

      it 'create a movie in database' do
        expect(json['title']).to eq('This is a new film')
        expect(json['release_date']).to eq('2018-10-14')
        expect(json['duration']).to eq(1)
        expect(json['country']).to eq('usa')
        expect(json['classification']).to eq('G')
        expect(json['loan_price'].to_f).to eq(5.0)
        expect(json['cover_url']).to eq('empty.pattern.png')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request with missing title attribute' do
      before {post "#{api_url}movies", params: {release_date: '2018-10-14'}}
      it 'returns validation error messages' do
        expect(json['errors']['title'].size).to eq(2)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when request with invalid too short title attribute' do
      before {post "#{api_url}movies", params: {title: 'a', release_date: '2018-10-14'}}
      it 'returns validation error messages' do
        expect(json['errors']['title'].size).to eq(1)
        expect(json['errors']['title'][0]).to match(/is too short/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /movies/:id' do
    let(:request_attributes) {{title: 'Toy story'}}

    context 'when the record exists' do
      before {put "#{api_url}movies/#{movie_id}", params: request_attributes}

      context 'when request is ok' do
        it 'updates the record' do
          expect(response.body).to be_empty
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'when request is invalid' do
        let(:request_attributes){{}}
      end
    end
  end
end
