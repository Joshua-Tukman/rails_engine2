class Api::V1::Merchants::MostItemsSoldController < ApplicationController

  def index
    merchants = Merchant.joins(invoices: [:invoice_items, :transactions])
                        .where("transactions.result = 'success'")
                        .group('merchants.id')
                        .select('merchants.id, merchants.name, sum(invoice_items.quantity) AS number_items')
                        .order('number_items DESC')
                        .limit(params[:quantity].to_i)
                        
    render json: MerchantSerializer.new(merchants)
  end
end