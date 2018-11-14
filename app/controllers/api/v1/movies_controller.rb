# frozen_string_literal: true

module Api::V1
  class MoviesController < ApplicationController
    before_action :authenticate_user!, only: %i[create update destroy]
    before_action :set_movie, only: %i[show update destroy]
    respond_to :json

    # GET /movies
    def index
      @movies = Movie.reduce(filter_movie_params).page(params[:current_page])
      render json: @movies, meta: pagination_dict(@movies)
    end

    # GET /movies/:id
    def show
      json_response(@movie)
    end

    # POST /movies
    def create
      @movie = Movie.create!(movie_params)
      json_response(@movie, :created)
    end

    # PUT /movies/:id
    def update
      @movie.update!(movie_params)
      json_response(@movie, :ok)
    end

    # DELETE /movies/:id
    def destroy
      @movie.cover.purge
      @movie.destroy
      head :no_content
    end

    private

    def pagination_dict(collection)
      {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.prev_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count
      }
    end


    def movie_params
      params.permit(:title, :release_date, :duration, :category_list,
                    :director_list, :writer_list, :actor_list, :country, :classification,
                    :imdb_code, :youtube_trailer_code, :loan_price, :created_at, :updated_at,
                    :cover, :synopsis)
    end

    def filter_movie_params
      params.permit(:title, :category, :classification, :sortBy, :sortDirection)
    end

    def set_movie
      @movie = Movie.includes(:categories, :directors, :writers, :actors)
                 .references(:categories, :directors, :writers, :actors).with_attached_cover
                 .find(params[:id])
    end
  end
end
