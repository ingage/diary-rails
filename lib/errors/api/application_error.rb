# frozen_string_literal: true

#
# API で エラーを投げるためのエラークラス
#
class Api::ApplicationError < ApplicationError

  def initialize(form_errors)
    super(form_errors.to_s)
    @form_errors = form_errors
  end

  def response_json
    @form_errors.full_messages
  end

end
