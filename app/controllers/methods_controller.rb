class MethodsController < ApplicationController
  helper_method :show_products, :count_price, :count_total_price
  before_action :authenticate_user!, except: :index

  private

  def count_price(object)
    sum = []
    object.products.each do |product|
      sum << product.price
    end
    @sum = sum.inject(:+)
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

end
