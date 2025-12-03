module OrdersHelper
  def order_status_color(status)
    case status
    when "pending"
      "warning"
    when "paid"
      "success"
    when "shipped"
      "info"
    when "delivered"
      "success"
    when "cancelled"
      "danger"
    else
      "light"
    end
  end

  def format_order_date(date)
    date.strftime("%B %d, %Y at %I:%M %p")
  end
end
