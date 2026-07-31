class Admin::ProvincesController < Admin::BaseController
  before_action :set_province, only: [:show, :edit, :update]

  def index
    @provinces = Province.order(:name)
  end

  def show
  end

  def edit
  end

  def update
    if @province.update(province_params)
      redirect_to admin_provinces_path,
                  notice: "Province updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_province
    @province = Province.find(params[:id])
  end

  def province_params
    params.require(:province).permit(
      :name,
      :code,
      :gst_rate,
      :pst_rate,
      :hst_rate
    )
  end
end