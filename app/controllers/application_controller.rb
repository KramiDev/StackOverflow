require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    # Rails.logger.debug("!!!!!!!!!!  #{exception.inspect} !!!!!!!!!!!!!!!!")
    if request.xhr?
      flash[:notice] = exception.message
      render js: "window.location.replace('#{root_path}')"
    else
      redirect_to root_path, alert: exception.message
    end
  end

  check_authorization unless: :devise_controller?
end
