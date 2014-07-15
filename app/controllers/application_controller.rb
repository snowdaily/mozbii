class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(roles: [], :email, :password, :password_confirmation) }
  end

  def after_sign_in_path_for(resource)
      ufro_index_path
  end

  def layout_by_resource
    if devise_controller?
      false
    else
      "application"
    end
  end
end
