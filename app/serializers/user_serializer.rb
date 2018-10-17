# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :first_name, :middle_name, :last_name

  def avatar_url
    if object.avatar.attached?
      rails_blob_path(object.avatar, only_path: true)
    else
      'empty.pattern.png'
    end
  end
end
