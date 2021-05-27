# frozen_string_literal: true

class Api::Journals::SearchForm < Api::ApplicationForm

  # ATTRIBUTES
  attribute :user_email, :string
  attribute :date,       :string

  # VALIDATIONS
  validates :user_email, presence: true
  validates :date,       presence: true

end
