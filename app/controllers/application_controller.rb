class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception

    def route_not_found
      render file: Rails.public_path.join('404.html'), status: :not_found, layout: false

    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:subscription_type])
  end
end
