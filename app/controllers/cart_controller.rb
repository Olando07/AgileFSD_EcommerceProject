class CartController < ApplicationController
  before_action :initialize_cart
  before_action :require_login, only: [ :show ]

  def show
    # Get products with their quantities
    @cart_items = []
    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      @cart_items << { product: product, quantity: quantity } if product
    end

    # Calculate total
    @subtotal = @cart_items.sum { |item| item[:product].price * item[:quantity] }
  end

  def add
    product_id = params[:product_id].to_s
    quantity = params[:quantity]&.to_i || 1

    if @cart[product_id]
      @cart[product_id] += quantity
    else
      @cart[product_id] = quantity
    end

    session[:cart] = @cart

    redirect_to cart_path, notice: "Product added to cart!"
  end

  def update
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      @cart[product_id] = quantity
    else
      @cart.delete(product_id)
    end

    session[:cart] = @cart

    redirect_to cart_path, notice: "Cart updated!"
  end

  def remove
    product_id = params[:product_id].to_s
    @cart.delete(product_id)
    session[:cart] = @cart

    redirect_to cart_path, notice: "Product removed from cart!"
  end

  def clear
    session[:cart] = {}
    redirect_to cart_path, notice: "Cart cleared!"
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def require_login
    unless user_signed_in?
      redirect_to login_path, alert: "You must be logged in to view your cart and place orders."
    end
  end
end
