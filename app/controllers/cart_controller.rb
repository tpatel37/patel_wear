class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    valid_ids = @cart.keys.reject(&:blank?)           
    @products = Product.where(id: valid_ids)
  end

  def add
    id = params[:id].to_s.strip                         
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

  def update_quantity
    id = params[:id].to_s.strip
    quantity = params[:quantity].to_i

    if session[:cart] && session[:cart][id]
      if quantity > 0
        session[:cart][id] = quantity
        flash[:notice] = "Quantity updated!"
      else
        session[:cart].delete(id)
        flash[:notice] = "Product removed from cart (quantity was set to 0)"
      end
    end

    redirect_to cart_path
  end
end
f