# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  rescue_from ServiceError, with: :error_response
end
