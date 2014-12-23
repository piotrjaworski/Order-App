class RatesController < ApplicationController

  def rate_products
    @products_to_rate = []
    current_user.orders.each do |order|
      order.products.each do |product|
        @products_to_rate << product
      end
    end
    @products_to_rate = @products_to_rate.uniq { |p| p.name }
  end

  def restaurants_rate
    @restaurants_to_rate = []
    current_user.orders.each do |order|
      order.restaurants.each do |restaurant|
        @restaurants_to_rate << restaurant
      end
    end
    @restaurants_to_rate = @restaurants_to_rate.uniq { |r| r.name }
  end

end
