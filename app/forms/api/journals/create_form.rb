# frozen_string_literal: true

class Api::Journals::CreateForm < Api::ApplicationForm

  # ATTRIBUTES
  attribute :user_email,  :string
  attribute :date,        :string
  attribute :memo,        :text
  attribute :secret_memo, :text
  attribute :leave_flag,  :boolean

  # VALIDATIONS
  validates :user_email, presence: true
  validates :date,       presence: true

  # TODO: 詳細データも必要

end
