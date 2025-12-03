class ProductsController < ApplicationController
  def index
    @products = Product.all

    # Filter by category
    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    # Filter by "new" products (added in last 3 days)
    if params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    end

    # Filter by "recently updated" (updated in last 3 days, but exclude new products)
    if params[:filter] == "updated"
      @products = @products.where("updated_at >= ? AND created_at < ?", 1.days.ago, 1.days.ago)
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
