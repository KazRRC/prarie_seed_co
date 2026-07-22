class Admin::CategoriesController < ApplicationController
  layout "admin"
  before_action :authenticate_customer!
  before_action :require_admin

  def index
    @categories = Category.order(:name)
                          .page(params[:page])
                          .per(9)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(:name)
                                  .page(params[:page])
                                  .per(9)
  end
end
