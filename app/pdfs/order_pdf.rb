class OrderPdf < Prawn::Document

  def initialize(today_orders)
    super(top_margin: 70)
    @today_orders = today_orders
    all_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    date = DateTime.now
    text date.strftime("Order from %F")
    line_items
    move_down 10
    fill_color "ff0000"
    text "Total to pay: " + sum(all_orders).to_s + " zl", size: 18, style: :bold
    move_down 20
    fill_color "0000ff"
    text date.strftime("Raport generated at %F %I:%M%p")
  end

  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["ID", "Order", "Who ordered", "Restaurant", "Price"]] +
    @today_orders.map do |order|
      if order.restaurant
        [order.id, order.short_info, order.user.name, order.restaurant.name, order.price]
      else
        [order.id, order.short_info, order.user.name, 'There is no restaurant', order.price]
      end
    end
  end

  def sum(object)
    sum = []
    object.each do |order|
      sum << order.price
    end
    @sum = sum.inject(:+)

  end

end
