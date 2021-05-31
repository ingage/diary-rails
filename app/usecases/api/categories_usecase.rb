# frozen_string_literal: true

#
# カテゴリ用のビジネスロジック
#
class Api::CategoriesUsecase < ApplicationUsecase

  class << self

    # TODO: 直接ハッシュを生成しているので一旦 rubocop を止める
    # rubocop:disable Metrics/MethodLength:
    def search(form)
      raise ArgumentError unless form.is_a?(Api::Categories::SearchForm)
      raise Api::BadRequestError, form.errors if form.invalid?

      [{
        id:              'improvement',
        name:            '機能改善',
        group_id:        'group1',
        capitalize_flag: false,
      }, {
        id:              'feature',
        name:            '機能追加',
        group_id:        'group1',
        capitalize_flag: true,
      }]
    end
    # rubocop:enable Metrics/MethodLength:

  end

end
