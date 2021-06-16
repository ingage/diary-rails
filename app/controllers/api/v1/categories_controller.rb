# frozen_string_literal: true

#
# /api/v1/journals API を実装するコントローラー
#
class Api::V1::CategoriesController < Api::V1::ApplicationController

  #
  # GET /api/v1/categories
  # 一覧取得
  #
  def index
    form = Api::Categories::SearchForm.new(params)
    render json: Api::CategoriesUsecase.search(form)
  end

end
