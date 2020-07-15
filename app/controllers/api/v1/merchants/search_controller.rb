class Api::V1::Merchants::SearchController < ApplicationController
  
  def index
    params[:name] = params[:name].downcase
    search = "%" + params[:name] + "%"
    merchants = Merchant.where("merchants.name LIKE ?", search)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    params[:name] = params[:name].downcase
    search = "%" + params[:name] + "%"
    merchant = Merchant.find_by("merchants.name LIKE ?", search)
    render json: MerchantSerializer.new(merchant)
  end 

end