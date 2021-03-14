class ApplicationController < ActionController::Base
  # Instructions for allowing login with username:
  # => https://github.com/heartcombo/devise/wiki/How-To%3A-Allow-users-to-sign-in-using-their-username-or-email-address
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
