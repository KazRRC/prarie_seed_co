class CheckoutsController < ApplicationController
before_action :authenticate_customer!

def show
if session[:cart].blank?
redirect_to cart_path,
alert: "Your cart is empty."
return
end

unless current_customer.province
  redirect_to edit_customer_registration_path,
              alert: "Please complete your shipping information first."
  return
end

@province = current_customer.province

@cart_items = build_cart_items

@subtotal = @cart_items.sum { |item| item[:total] }

@gst = @subtotal * @province.gst_rate / 100
@pst = @subtotal * @province.pst_rate / 100
@hst = @subtotal * @province.hst_rate / 100

@grand_total = @subtotal + @gst + @pst + @hst


end

def create
if session[:cart].blank?
redirect_to cart_path,
alert: "Your cart is empty."
return
end

unless current_customer.province
  redirect_to edit_customer_registration_path,
              alert: "Please complete your shipping information first."
  return
end

cart_items = build_cart_items

stripe_session = Stripe::Checkout::Session.create(
  mode: "payment",

  customer_email: current_customer.email,

  success_url: success_checkout_url(
    session_id: "{CHECKOUT_SESSION_ID}"
  ),

  cancel_url: cancel_checkout_url,

  line_items: cart_items.map do |item|
    {
      quantity: item[:quantity],

      price_data: {
        currency: "cad",

        product_data: {
          name: item[:product].name
        },

        unit_amount: (item[:price].to_d * 100).to_i
      }
    }
  end
)

redirect_to stripe_session.url,
            allow_other_host: true,
            status: :see_other


rescue Stripe::StripeError => e

Rails.logger.error "Stripe Error: #{e.message}"

redirect_to checkout_path,
            alert: "There was a problem connecting to Stripe. Please try again."

rescue => e


Rails.logger.error e.full_message

redirect_to checkout_path,
            alert: "Unable to start payment. Please try again."


end

def success
if params[:session_id].blank?
redirect_to checkout_path,
alert: "Payment session could not be found."
return
end

stripe_session =
  Stripe::Checkout::Session.retrieve(params[:session_id])

unless stripe_session.payment_status == "paid"
  redirect_to checkout_path,
              alert: "Payment was not completed."
  return
end

existing_order =
  Order.find_by(payment_id: stripe_session.payment_intent)

if existing_order
  session[:cart] = {}

  redirect_to order_path(existing_order),
              notice: "Your order has already been processed."
  return
end

province = current_customer.province

unless province
  redirect_to edit_customer_registration_path,
              alert: "Please complete your shipping information first."
  return
end

order = current_customer.orders.create!(
  status: "paid",

  payment_id: stripe_session.payment_intent,

  paid_at: Time.current,

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
  hst_rate: province.hst_rate,

  subtotal: 0,
  total: 0
)

subtotal = 0

session[:cart].each do |product_id, quantity|

  product = Product.find(product_id)

  price =
    product.on_sale? ? product.sale_price : product.price

  line_total = price * quantity

  order.order_items.create!(
    product: product,
    product_name: product.name,
    quantity: quantity,
    unit_price: price,
    line_total: line_total
  )

  subtotal += line_total
end

gst = subtotal * province.gst_rate / 100
pst = subtotal * province.pst_rate / 100
hst = subtotal * province.hst_rate / 100

total = subtotal + gst + pst + hst

order.update!(
  subtotal: subtotal,
  gst_amount: gst,
  pst_amount: pst,
  hst_amount: hst,
  total: total
)

# Empty cart ONLY after successful payment
session[:cart] = {}

redirect_to order_path(order),
            notice: "Payment successful! Thank you for your order."

rescue Stripe::StripeError => e

Rails.logger.error "Stripe Error: #{e.message}"

redirect_to checkout_path,
            alert: "We could not verify your payment."

rescue => e

Rails.logger.error e.full_message

redirect_to checkout_path,
            alert: "There was a problem processing your order."

end

def cancel
redirect_to checkout_path,
alert: "Payment was cancelled. Your cart has not been changed."
end

private

def build_cart_items
session[:cart].map do |product_id, quantity|
  product = Product.find(product_id)

  price =
    product.on_sale? ? product.sale_price : product.price

  {
    product: product,
    quantity: quantity,
    price: price,
    total: price * quantity
  }

end

end
end
