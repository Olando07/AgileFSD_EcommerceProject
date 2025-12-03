class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_order, only: [:show]
  
  # Show checkout page with order preview
  def new
    if session[:cart].blank? || session[:cart].empty?
      redirect_to products_path, alert: "Your cart is empty!"
      return
    end
    
    unless current_user.province_id.present? && current_user.street_address.present?
      redirect_to edit_user_path(current_user), alert: "Please complete your address before checkout."
      return
    end
    
    # Build cart items array
    @cart_items = []
    session[:cart].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        @cart_items << { 
          product: product, 
          quantity: quantity,
          line_total: product.price * quantity 
        }
      end
    end
    
    @subtotal = @cart_items.sum { |item| item[:line_total] }
    
    @province = current_user.province
    
    @gst = (@subtotal * @province.gst).round(2)
    @pst = (@subtotal * @province.pst).round(2)
    @hst = (@subtotal * @province.hst).round(2)
    
    @total = (@subtotal + @gst + @pst + @hst).round(2)
  end
  
  # Create the order
  def create
    if session[:cart].blank? || session[:cart].empty?
      redirect_to products_path, alert: "Your cart is empty!"
      return
    end
    
    # Build cart items and calculate totals
    cart_items = []
    session[:cart].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        cart_items << { 
          product: product, 
          quantity: quantity,
          line_total: product.price * quantity 
        }
      end
    end
    
    subtotal = cart_items.sum { |item| item[:line_total] }
    province = current_user.province
    gst = (subtotal * province.gst).round(2)
    pst = (subtotal * province.pst).round(2)
    hst = (subtotal * province.hst).round(2)
    total = (subtotal + gst + pst + hst).round(2)
    
    @order = current_user.orders.build(
      subtotal: subtotal,
      gst: gst,
      pst: pst,
      hst: hst,
      total: total,
      status: "pending"
    )
    
    # Use transaction to ensure all-or-nothing save
    ActiveRecord::Base.transaction do
      if @order.save
        cart_items.each do |item|
          @order.order_items.create!(
            product_id: item[:product].id,
            quantity: item[:quantity],
            price_snapshot: item[:product].price,  # Freeze price at order time
            name_snapshot: item[:product].name     # Freeze name at order time
          )
        end
        
        session[:cart] = {}
        
        redirect_to order_path(@order), notice: "Order placed successfully! Order ##{@order.id}"
      else
        redirect_to checkout_path, alert: "There was an error processing your order. Please try again."
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to checkout_path, alert: "Order creation failed: #{e.message}"
  end
  
  # Show single order details
  def show
    @order_items = @order.order_items.includes(:product)
  end
  
  # Show all orders for current user
  def index
    @orders = current_user.orders
                          .order(created_at: :desc)
                          .page(params[:page])
                          .per(10)
  end
  
  private
  
  def set_order
    @order = current_user.orders.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path, alert: "Order not found."
  end
  
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end
end
