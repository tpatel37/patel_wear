class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def edit
    @customer = current_customer
    @provinces = Province.all
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to orders_path, notice: "Address updated successfully."
    else
      @provinces = Province.all
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:address, :province_id)
  end
end
k