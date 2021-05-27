# frozen_string_literal: true

#
# /api/v1/journals API を実装するコントローラー
#
class Api::V1::JournalsController < Api::V1::ApplicationController

  #
  # GET /api/v1/journals
  # 一覧取得
  #
  def index
    form = Api::Journals::SearchForm.new(params)
    render json: Api::JournalsUsecase.search(form)
  end

  #
  # GET /api/v1/journals/:id
  # ID指定での個別取得
  #
  def show
    form = Api::Journals::FindForm.new(params)
    render json: Api::JournalsUsecase.find(form)
  end

  #
  # POST /api/v1/journals
  # 日報作成
  #
  def create
    form = Api::Journals::CreateForm.new(params)
    render status: :created, json: Api::JournalsUsecase.create(form)
  end

end
