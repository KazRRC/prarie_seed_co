class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,
                if: :devise_controller?

  before_action :initialize_cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :first_name,
        :last_name,
        :phone_number,
        :street_address,
        :city,
        :province,
        :postal_code,
        :country
      ]
    )

    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        :first_name,
        :last_name,
        :phone_number,
        :street_address,
        :city,
        :province,
        :postal_code,
        :country
      ]
    )
  end

  private

  def require_admin
    unless customer_signed_in? && current_customer.admin?
      redirect_to root_path,
                  alert: "You are not authorized to access that page."
    end
  end

  def initialize_cart
    session[:cart] ||= {}
  end
end