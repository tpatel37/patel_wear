class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    session[:customer_return_to] || root_path
  end
end
