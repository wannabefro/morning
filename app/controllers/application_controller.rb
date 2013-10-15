class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :update_sanitized_params, if: :devise_controller?

  protected

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password) }
  end
end
