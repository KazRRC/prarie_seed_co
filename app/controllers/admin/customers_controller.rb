class Admin::CustomersController < Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer
                   .includes(:province)
                   .order(:last_name, :first_name)
  end

  def show
    @orders = @customer.orders.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customers_path,
                  notice: "Customer updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy

    redirect_to admin_customers_path,
                notice: "Customer deleted."
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :street_address,
      :city,
      :province_id,
      :postal_code,
      :country,
      :admin
    )
  end
end