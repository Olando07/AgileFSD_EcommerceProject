class ProductsController < ApplicationController
  def index
    @products = Product.all

    # Filter by category
    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    # Filter by search
    if params[:search].present?
      @products = @products.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    end

    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end
