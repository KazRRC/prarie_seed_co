class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  def destroy
  @order.destroy
  redirect_to admin_orders_path,
              notice: "Order deleted successfully."
end

  def index
    @orders = Order.includes(:customer)
                   .order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to admin_order_path(@order),
                  notice: "Order updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end