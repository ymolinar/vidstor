# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if !resource.errors.empty?
      respond_with_error resource
    else
      render json: resource
    end
  end

  def respond_with_error(resource)
    key = resource.errors.keys[0]
    message = "#{key.to_s.titleize} #{resource.errors.messages[key][0]}"
    json_response({ message: message, errors: resource.errors }, :unprocessable_entity)
  end

  def respond_to_on_destroy
    head :no_content
  end

  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end
