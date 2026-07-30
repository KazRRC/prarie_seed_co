class Admin::DashboardController < Admin::BaseController
  layout "admin"

  before_action :authenticate_customer!
  before_action :require_admin

  def index
    @product_count   = Product.count
    @category_count  = Category.count
    @customer_count  = Customer.count
    @order_count     = Order.count

    @recent_orders = Order.includes(:customer)
                          .order(created_at: :desc)
                          .limit(5)

    @recent_customers = Customer.order(created_at: :desc)
                                .limit(5)

    @low_stock_products = Product.where("stock_quantity < ?", 10)
                                 .order(:stock_quantity)
                                 .limit(5)
  end

  private

  def require_admin
    redirect_to root_path, alert: "Access denied." unless current_customer.admin?
  end
end