class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  add_flash_types :info, :error, :success, :notice
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation bio photo])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation bio photo])
  end

  def after_sign_out_path_for(_scope)
    root_path
  end
end
