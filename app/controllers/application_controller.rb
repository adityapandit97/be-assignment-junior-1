class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:name])
  end
end

