#encoding: utf-8
class OrderPdf < Prawn::Document

  def initialize(today_orders)
    super(top_margin: 70)
    @orders = today_orders
    @all_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @date = DateTime.now
    text @date.strftime("Order from %F."), style: :bold
    line_items
    print_summarization
  end

  def print_summarization
    move_down 14
    fill_color "ff0000"
    text "Total to pay: " + order_price(@all_orders).to_s + " zl", size: 18, style: :bold
    move_down 20
    fill_color "0000ff"
    text @date.strftime("Raport generated on %F at %I:%M%p."), size: 10
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
    [["Order", "Who ordered", "Restaurant", "Price"]] +
    @orders.map do |order|
      [order.products.map(&:name).join(", "), order.user.try(:name), order.restaurant.try(:name), order.products.sum(:price)]
    end
  end

  def order_price(objects)
    sum = []
    objects.each do |order|
      order.products.each { |product| sum << product.price }
    end
    @sum = sum.inject(:+)
  end

end
