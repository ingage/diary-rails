# frozen_string_literal: true

#
# Form の基底クラス
# 主な処理
# - Strong Parameter
# - Validation
#
class ApplicationForm

  # Rails.logger.debug を logger.debug などを使えるようにする
  include ActiveSupport::Configurable
  include AbstractController::Logger

  include ::ActiveModel::Model
  include ::ActiveModel::Attributes

  #
  # Constructor
  #
  def initialize(params = nil)
    p = if params.present?
          params.permit(self.class.attribute_names.map(&:to_sym))
        else
          {}
        end
    super(p)
  end

end
