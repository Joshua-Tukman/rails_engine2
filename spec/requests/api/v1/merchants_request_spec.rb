require 'rails_helper'

RSpec.describe "Merchants API" do
  xit "returns a list of merchants" do
    merchant = create(:merchant)
    create_list(:item, 10, merchant_id: merchant.id)
    
    get '/api/v1/items'

    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(10)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id
    
    get "/api/v1/merchants/#{id}"

    json_response = JSON.parse(response.body, symbolize_names: true)
    
    merchant = Merchant.find_by(id: id)
    expect(response).to be_successful
    
    expect(json_response[:data][:attributes][:name]).to eq(merchant.name)
  end

  xit "can create an item" do
    merchant = create(:merchant)
    item_params = { name: "Cold Beer", description: "Super tasty and refreshing", unit_price: 10, merchant_id: merchant.id}

    post "/api/v1/items", params: item_params 
    
    json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    item = json[:data]
    expect(item[:attributes][:name]).to eq("Cold Beer")
  end

  xit "can delete an item" do
    merchant = create(:merchant)
    item_params = { name: "Cold Beer", description: "Super tasty and refreshing", unit_price: 10, merchant_id: merchant.id}

    post "/api/v1/items", params: item_params 

    item = Item.last

    expect(item.name).to eq("Cold Beer")
    
    delete "/api/v1/items/#{item.id}"
    
    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  xit "can update an item" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    
    previous_name = Item.last.name
    item_params = { name: "Skull and Sword" }

    put "/api/v1/items/#{id}", params: item_params
    item = Item.find_by(id: id)
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(json_response[:data][:attributes][:name]).to eq(item.name)
  end
end