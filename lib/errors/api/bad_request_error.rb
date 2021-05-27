# frozen_string_literal: true

#
# API で 400 bad_request を投げるためのエラークラス
#
class Api::BadRequestError < Api::ApplicationError
end
