class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :province_id])
  end
end
