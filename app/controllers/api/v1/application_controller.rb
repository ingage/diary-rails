# frozen_string_literal: true

#
# API 用の共通コントローラー
#
class Api::V1::ApplicationController < ApplicationController

  # 500 internal_server_error
  # rescue_from StandardError do |error|
  #   render status: :internal_server_error, json: error.message
  # end

  # 400 bad_request
  rescue_from Api::BadRequestError do |error|
    render status: :bad_request, json: error.response_json
  end

  # 401 unauthorized
  rescue_from Api::UnauthorizedError do |error|
    render status: :unauthorized, json: error.response_json
  end

  # 403 forbidden
  rescue_from Api::ForbiddenError do |error|
    render status: :forbidden, json: error.response_json
  end

  # 404 not_found
  rescue_from Api::NotFoundError do |error|
    render status: :not_found, json: error.response_json
  end

  # 429 too_many_requests
  rescue_from Api::TooManyRequestsError do |error|
    render status: :too_many_requests, json: error.response_json
  end

end
