class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    @products = @products.order(:name)
  end

  def show
    @product = Product.find(params[:id])
  end
end
