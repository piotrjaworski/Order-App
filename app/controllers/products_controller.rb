class ProductsController < MethodsController

  def index
    @products = Product.all
    @products = @products.paginate(page: params[:page], per_page: 12)
    typehead
  end

end
