class ProductsController < ApplicationController

  def index
    restaurants = Restaurant.all
    @products = []
    restaurants.each do |restaurant|
      products = restaurant.products.select("distinct(name), restaurant_id, price, id")
      @products << products
    end
    @products.flatten!
  end

end
