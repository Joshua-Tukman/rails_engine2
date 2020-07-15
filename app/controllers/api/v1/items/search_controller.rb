class Api::V1::Items::SearchController < ApplicationController
  
  def index
    search = "%" + params[:name] + "%"
    items = Item.where("LOWER(items.name) LIKE LOWER(?)", search)
    render json: ItemSerializer.new(items)
  end

  def show
    search = "%" + params[:name] + "%"
    item = Item.find_by("LOWER(items.name) LIKE LOWER(?)", search)
    render json: ItemSerializer.new(item)
  end 

end