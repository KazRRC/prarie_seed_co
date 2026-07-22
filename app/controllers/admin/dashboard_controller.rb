class Admin::DashboardController < ApplicationController
  layout "admin"
  before_action :authenticate_customer!
  before_action :require_admin

def index
  @product_count = Product.count
  @category_count = Category.count
  @customer_count = Customer.count
end
end