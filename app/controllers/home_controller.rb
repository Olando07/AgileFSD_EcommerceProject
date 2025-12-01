class HomeController < ApplicationController
  def index
    @featured_products = Product.limit(8)  # Show 8 featured products
  end
end
