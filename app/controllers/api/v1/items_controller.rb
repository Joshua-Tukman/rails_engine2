class Api::V1::ItemsController < ApplicationController
  
  def index
    items = Item.all 
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params["id"])
    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    item = Item.find(params[:id])
    item.delete
    render json: ItemSerializer.new(item)
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item)
  end

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end