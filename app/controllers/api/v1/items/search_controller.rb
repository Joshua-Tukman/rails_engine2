class Api::V1::Items::SearchController < ApplicationController
  
  def index   
   render json: ItemSerializer.new(Item.parameter_search(items_params))
  end

  def show
    search = "%" + params[:name] + "%"
    item = Item.find_by("LOWER(items.name) LIKE LOWER(?)", search)
    render json: ItemSerializer.new(item)
  end
  
  private

  def items_params
    params.permit(:name, :description)
  end

end