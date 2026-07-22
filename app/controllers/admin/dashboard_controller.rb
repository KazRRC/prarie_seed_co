class Admin::DashboardController < ApplicationController
  before_action :authenticate_customer!
  before_action :require_admin

  def index
  end
end