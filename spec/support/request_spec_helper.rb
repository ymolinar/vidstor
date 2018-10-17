# frozen_string_literal: true
require 'devise/jwt/test_helpers'

module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  module AuthenticationHelper
    def auth_headers(user)
      Devise::JWT::TestHelpers.auth_headers({}, user)
    end
  end
end