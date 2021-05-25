# frozen_string_literal: true

#
# Form の基底クラス
# 主な処理
# - Strong Parameter
# - Validation
#
class ApplicationForm

  include ::ActiveModel::Model
  include ::ActiveModel::Attributes

end
