#encoding: utf-8
class OrderPdf < Prawn::Document

  def initialize(today_orders)
    super(top_margin: 70)
    @orders = today_orders
    all_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    date = DateTime.now
    text date.strftime("Order from %F."), style: :bold
    line_items
    move_down 14
    fill_color "ff0000"
    text "Total to pay: " + count_total_price(all_orders).to_s + " zl", size: 18, style: :bold
    move_down 20
    fill_color "0000ff"
    text date.strftime("Raport generated on %F at %I:%M%p."), size: 10
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
    @orders.map do |order|
      if order.restaurant
        [order.id, order.products.map(&:name).join(", "), order.user.name, order.restaurant.name, order.products.map(&:price).inject(:+)]
      else
        [order.id, order.products.map(&:name).join(", "), order.user.name, 'There is no restaurant', order.products.map(&:price).inject(:+)]
      end
    end
  end

  def count_total_price(objects)
    today_sum = []
    objects.each do |order|
      order.products.each do |product|
        today_sum << product.price
      end
    end
    @today_sum = today_sum.inject(:+)
  end

end
