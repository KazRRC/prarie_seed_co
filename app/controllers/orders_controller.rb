class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def create
    if session[:cart].blank?
      redirect_to cart_path,
                  alert: "Your cart is empty."
      return
    end

    order = current_customer.orders.create!(
      status: "pending",
      total: 0
    )

    total = 0

    session[:cart].each do |product_id, quantity|

      product = Product.find(product_id)

      price = product.on_sale? ? product.sale_price : product.price

      order.order_items.create!(
        product: product,
        quantity: quantity,
        price: price
      )

      total += price * quantity

    end

    order.update!(total: total)

    session[:cart] = {}

    redirect_to order_path(order),
                notice: "Thank you for your order!"
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end
end