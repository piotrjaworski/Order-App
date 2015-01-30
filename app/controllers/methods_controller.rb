class MethodsController < ApplicationController
  helper_method :show_products, :count_price, :count_total_price
  before_action :authenticate_user!, except: :index

  private

  def count_price(object)
    object.products.sum(:price)
  end

  def count_total_price(objects)
    today_sum = []
    objects.each do |order|
      order.products.each { |product| today_sum << product.price }
    end
    @today_sum = today_sum.inject(:+)
  end

  def show_products(object)
    object.products.pluck(:name).join(", ")
  end

  def orders_collects_calls
    @orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @today_collect = Collect.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

end
