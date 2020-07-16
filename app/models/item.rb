class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy

  def self.parameter_search(search_params)
    search_name = search_params[:name].blank? ? nil : "%" + search_params[:name].downcase + "%"
    search_description =  search_params[:description].blank? ? nil : "%" + search_params[:description].downcase + "%"

    if search_name && search_description
       items = Item.where("LOWER(items.name) LIKE ? and LOWER(items.description) LIKE ?", search_name, search_description)
    elsif search_description
       items = Item.where("LOWER(items.description) LIKE ?", search_description)
    elsif search_name
       items = Item.where("LOWER(items.name) LIKE ?", search_name)   
    end
    items
  end
end
