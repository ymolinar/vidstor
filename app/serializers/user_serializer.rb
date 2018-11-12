# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :first_name, :middle_name, :last_name, :avatar_url, :loans_counter

  def avatar_url
    if object.avatar.attached?
      rails_blob_path(object.avatar, only_path: true)
    else
      'avatar_2x.png'
    end
  end
end
