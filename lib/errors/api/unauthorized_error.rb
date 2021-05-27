# frozen_string_literal: true

#
# API で 401 unauthorized を投げるためのエラークラス
#
class Api::UnauthorizedError < Api::ApplicationError
end
