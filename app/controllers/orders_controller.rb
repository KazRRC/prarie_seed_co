class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def create
    if session[:cart].blank?
      redirect_to cart_path,
                  alert: "Your cart is empty."
      return
    end
unless current_customer.province
  redirect_to edit_customer_registration_path,
              alert: "Please complete your shipping address before checking out."
  return
end
    order = current_customer.orders.create!(
      status: "pending",
      total: 0
    )
    province = current_customer.province

    order.update!(
      first_name: current_customer.first_name,
      last_name: current_customer.last_name,
      phone_number: current_customer.phone_number,
      street_address: current_customer.street_address,
      city: current_customer.city,
      province: province.name,
      postal_code: current_customer.postal_code,
      country: current_customer.country,

      gst_rate: province.gst_rate,
      pst_rate: province.pst_rate,
      hst_rate: province.hst_rate
    )
    total = 0

    session[:cart].each do |product_id, quantity|

      product = Product.find(product_id)

      price = product.on_sale? ? product.sale_price : product.price

      line_total = price * quantity

      order.order_items.create!(
        product: product,
        product_name: product.name,
        quantity: quantity,
        unit_price: price,
        line_total: line_total
      )

      total += line_total

    end

subtotal = total.to_d

gst = subtotal * province.gst_rate / 100
pst = subtotal * province.pst_rate / 100
hst = subtotal * province.hst_rate / 100

grand_total = subtotal + gst + pst + hst

    order.update!(
      subtotal: subtotal,

      gst_amount: gst,
      pst_amount: pst,
      hst_amount: hst,

      total: grand_total
    )

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