class Api::V1::MerchantItemsController < ApplicationController

  def index
    items = Merchant.find(params[:merchant_id]).items
    render json: ItemSerializer.new(items)
  end

  def show
    id = Item.find(params[:item_id]).merchant_id
    merchant = Merchant.find(id)
    render json: MerchantSerializer.new(merchant)
  end
end