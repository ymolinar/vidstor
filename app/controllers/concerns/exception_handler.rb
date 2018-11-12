# frozen_string_literal: true

module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |e|
      json_response({ message: e.message + ' test', errors: [] }, :internal_server_error)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message, errors: e.record.errors }, :unprocessable_entity)
    end
  end
end