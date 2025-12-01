class ProductsController < ApplicationController
  def index
    @products = Product.all

    # Filter by category
    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    # Filter by search
    if params[:search].present?
      @products = @products.where("name LIKE ? OR decription LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end
