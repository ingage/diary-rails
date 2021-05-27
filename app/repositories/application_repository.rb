# frozen_string_literal: true

#
# Repository の基底クラス
#
class ApplicationRepository

  # Rails.logger.debug を logger.debug などを使えるようにする
  include ActiveSupport::Configurable
  include AbstractController::Logger

  # private constructor
  private_class_method :new

end
