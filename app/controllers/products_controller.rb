class ProductsController < MethodsController

  def index
    @products = Product.all
    @products = @products.paginate(page: params[:page], per_page: 12)
    typehead
  end

  def show
    @product = Product.find(params[:id])
    @last_rates = @product.rates.limit(5)
  end

end
