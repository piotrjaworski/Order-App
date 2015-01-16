class ProductsController < MethodsController

  def index
    @products = Product.where.not(restaurant_id: nil)
                        .select("DISTINCT ON(name) name, restaurant_id, price, updated_at")
                        .order("name, updated_at")
    @products = @products.paginate(page: params[:page], per_page: 12)
    typehead
  end

end
