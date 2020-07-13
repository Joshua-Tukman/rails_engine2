class Api::V1::CustomersController < ApplicationController
  
  def index
    @customers = Customer.all 
  end

  def import
    Customer.import(params[:file])
    redirect_to root_url, notice: "Customer Data Imported!"
  end
end