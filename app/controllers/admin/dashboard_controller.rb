class Admin::DashboardController < ApplicationController
  layout "admin"
  before_action :authenticate_customer!
  before_action :require_admin

def index
  @product_count = Product.count
  @category_count = Category.count
  @customer_count = Customer.count
end
panel "Store Statistics" do
  para "Customers: #{Customer.count}"
  para "Products: #{Product.count}"
  para "Orders: #{Order.count}"

  para "Revenue: $#{Order.sum(:total)}"
end
end