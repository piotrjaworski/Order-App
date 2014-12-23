class MethodsController < ApplicationController
  helper_method :show_products, :count_price, :count_total_price
  before_action :authenticate_user!, except: :index

  private

  def count_price(object)
    object.products.map(&:price).inject(:+)
  end

  def count_total_price(objects)
    today_sum = []
    objects.each do |order|
      order.products.each { |product| today_sum << product.price }
    end
    @today_sum = today_sum.inject(:+)
  end

  def show_products(object)
    object.products.map(&:name).join(", ")
  end

  def typehead
    products = Product.select(:name).distinct.map(&:name)
    restaurants = Restaurant.select(:name).distinct.map(&:name)
    @typehead = products + restaurants
    @typehead.uniq!
    @typehead
  end

  def orders_collects_calls
    @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @today_collect = Collect.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

end
