class ApplicationController < ActionController::Base
   class ProductsController < ApplicationController
    def show
      @product = Product.find(params[:id])
    end
  end
end