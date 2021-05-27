# frozen_string_literal: true

#
# API で 403 forbidden を投げるためのエラークラス
#
class Api::ForbiddenError < Api::ApplicationError
end
