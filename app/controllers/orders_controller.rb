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
      status: :new,
      total: 0
    )


    # rest of your order creation code here

  end


  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end


  def show
    @order = current_customer.orders.find(params[:id])
  end


end