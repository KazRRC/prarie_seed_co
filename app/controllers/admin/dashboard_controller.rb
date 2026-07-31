class Admin::DashboardController < Admin::BaseController
  def index
    @product_count = Product.count
    @category_count = Category.count
    @customer_count = Customer.count
    @order_count = Order.count

    @recent_orders = Order.includes(:customer)
                          .order(created_at: :desc)
                          .limit(5)

    @recent_customers = Customer.order(created_at: :desc)
                                .limit(5)

    @low_stock_products = Product.where("stock_quantity < ?", 10)
                                 .order(:stock_quantity)
                                 .limit(5)
  end
end