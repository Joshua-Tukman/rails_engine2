class Api::V1::Merchants::RevenueController < ApplicationController
  
  def index
   merchants = Merchant.joins(invoices: [:invoice_items, :transactions])
                       .where("transactions.result = 'success'")
                       .group('merchants.id')
                       .select('merchants.id, merchants.name, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
                       .order('revenue DESC')
                       .limit(params[:quantity].to_i)

   render json: MerchantSerializer.new(merchants)                            
  end

  def show
    render json: ItemSerializer.new(item)
  end 

end