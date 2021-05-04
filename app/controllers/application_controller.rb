# frozen_string_literal: true

#
# base class for controller in application
#
class ApplicationController < ActionController::Base

  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!

  private

  def authenticate_user!
    redirect_to(root_path) unless signed_in?
  end

  def signed_in?
    # TODO: トークンによるログイン検証
    session[:userinfo].present?
  end

  helper_method :signed_in?

end
