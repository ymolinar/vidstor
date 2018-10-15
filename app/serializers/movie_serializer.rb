# frozen_string_literal: true

class MovieSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :release_date, :duration, :country, :classification,
             :imdb_code, :youtube_trailer_code, :loan_price, :category_list, :writer_list,
             :director_list, :actor_list, :cover_url

  def cover_url
    if object.cover.attached?
      rails_blob_path(object.cover, only_path: true)
    else
      'empty.pattern.png'
    end
  end
end