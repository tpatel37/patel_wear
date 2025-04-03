class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    valid_ids = @cart.keys.reject(&:blank?)             # remove blank keys
    @products = Product.where(id: valid_ids)
  end

  def add
    id = params[:id].to_s.strip                         # sanitize and stringify ID
    return redirect_to products_path, alert: "Invalid product ID." if id.blank?

    session[:cart] ||= {}
    session[:cart][id] ||= 0
    session[:cart][id] += 1

    redirect_to cart_path, notice: "Product added to cart!"
  end

  def remove
    id = params[:id].to_s.strip
    session[:cart]&.delete(id)
    redirect_to cart_path, notice: "Product removed from cart."
  end
end
