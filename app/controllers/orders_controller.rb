class OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:index, :new, :create, :show, :confirm_payment, :edit, :update]

  def new
    @order = Order.new
    @provinces = Province.all
  end

  def create
    @provinces = Province.all
    if session[:cart].blank?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    customer = current_customer
    province = customer.province

    gst_rate = province.gst.to_f
    pst_rate = province.pst.to_f
    hst_rate = province.hst.to_f

    subtotal = 0
    cart = session[:cart] || {}
    products = Product.where(id: cart.keys)

    @order = Order.new(
      customer: customer,
      province_id: province.id,
      address: customer.address,         
      gst: gst_rate,                     
      pst: pst_rate,
      hst: hst_rate,
      status: "pending"
    )

    if @order.save
      products.each do |product|
        quantity = cart[product.id.to_s].to_i
        next if quantity <= 0

        price = product.price
        item_subtotal = price * quantity
        subtotal += item_subtotal

        @order.order_items.create!(
          product: product,
          quantity: quantity,
          price: price
        )
      end

      taxes = subtotal * (gst_rate + pst_rate + hst_rate)
      total = subtotal + taxes
      @order.update(total: total)

      session[:cart] = {}
      redirect_to new_payment_path(order_id: @order.id)
    else
      render :new
    end
  end

  def edit
    @order = current_customer.orders.find(params[:id])
  end

  def update
    @order = current_customer.orders.find(params[:id])
    if @order.update(order_params)
      redirect_to order_path(@order), notice: "Address updated successfully!"
    else
      render :edit
    end
  end

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @order_items = @order.order_items.includes(:product)
    @subtotal = @order_items.sum { |item| item.price * item.quantity }

    @gst_amount = @subtotal * @order.gst
    @pst_amount = @subtotal * @order.pst
    @hst_amount = @subtotal * @order.hst
    @taxes = @gst_amount + @pst_amount + @hst_amount
    @total = @order.total
  end

  def confirm_payment
    order = current_customer.orders.last
    if order.present?
      order.update(status: "paid", payment_id: params[:paypal_order_id])
      redirect_to order_path(order), notice: "Payment successful!"
    else
      redirect_to root_path, alert: "No order found to confirm."
    end
  end

  def index
    @orders = current_customer.orders.includes(order_items: :product)
  end

  private

  def order_params
    params.require(:order).permit(:address)
  end
end
l