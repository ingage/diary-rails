# frozen_string_literal: true

#
# ログイン用のビジネスロジック
#
class Api::JournalsUsecase < ApplicationUsecase

  class << self

    def search(form)
      raise ArgumentError unless form.is_a?(Api::Journals::SearchForm)
      raise Api::BadRequestError, form.errors if form.invalid?

      JournalRepository.list(form.user_email, form.date)
    end

    def find(form)
      raise ArgumentError unless form.is_a?(Api::Journals::FindForm)
      raise Api::BadRequestError, form.errors if form.invalid?
    end

    def create(form)
      raise ArgumentError unless form.is_a?(Api::Journals::CreateForm)
      raise Api::BadRequestError, form.errors if form.invalid?
    end

  end

end
