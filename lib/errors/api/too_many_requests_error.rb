# frozen_string_literal: true

#
# API で 429 too_many_requests を投げるためのエラークラス
#
class Api::TooManyRequestsError < Api::ApplicationError
end
