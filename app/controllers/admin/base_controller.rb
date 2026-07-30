class Admin::BaseController < ApplicationController
  layout "admin"

  before_action :authenticate_customer!
  before_action :require_admin

  private

  def require_admin
    return if current_customer.admin?

    redirect_to root_path, alert: "Access denied."
  end
end