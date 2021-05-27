# frozen_string_literal: true

#
# Entity の基底クラス
#
class ApplicationEntity

  # Rails.logger.debug を logger.debug などを使えるようにする
  include ActiveSupport::Configurable
  include AbstractController::Logger

  include ::ActiveModel::Model
  include ::ActiveModel::Attributes

end
