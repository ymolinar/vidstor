# frozen_string_literal: true

module Api::V1
  class CategoriesController < ApplicationController
    def index
      @categories = ActsAsTaggableOn::Tag.for_context(:categories).order(
        taggings_count: :desc
      ).all
      json_response @categories
    end
  end
end
