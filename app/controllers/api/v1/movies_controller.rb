# frozen_string_literal: true

module Api::V1
  class MoviesController < ApplicationController
    before_action :set_movie, only: [:show, :update, :destroy]

    # GET /movies
    def index
      @movies = Movie.all
      json_response(@movies)
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
      @movie.update(movie_params)
      head :no_content
    end

    # DELETE /movies/:id
    def destroy
      @movie.cover.purge
      @movie.destroy
      head :no_content
    end

    private

    def movie_params
      params.permit(:title, :release_date, :duration, :category_list,
                    :director_list, :writer_list, :actor_list, :country, :classification,
                    :imdb_code, :youtube_trailer_code, :loan_price, :created_at, :updated_at,
                    :cover
      )
    end

    def set_movie
      @movie = Movie.find(params[:id])
    end
  end
end