# frozen_string_literal: true

#
# base class for controller in application
#
class ApplicationController < ActionController::Base
  private

  def authenticate_user!
    redirect_to(root_path) unless signed_in?
  end

  def signed_in?
    session[:userinfo].present?
  end

  helper_method :signed_in?
end
