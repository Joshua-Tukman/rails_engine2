require 'rails_helper'

RSpec.describe "Merchants API" do
  it "returns a list of merchants" do
    merchant = create_list(:merchant, 10)
    
    get '/api/v1/merchants'

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

  it "can create a new merchant and delete a merchant" do
    #merchant = create(:merchant)
    merchant_params = { name: "Bones Brigade" }

    post "/api/v1/merchants", params: merchant_params 
    merchant = Merchant.last
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    
    merchant_info = json_response[:data]
    expect(merchant_info[:attributes][:name]).to eq(merchant.name)
    
    delete "/api/v1/merchants/#{merchant.id}"
    
    expect(response).to be_successful
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update an merchant" do
    id = create(:merchant).id

    previous_name = Merchant.last.name
    merchant_params = { name: "The Grateful Goose" }

    put "/api/v1/merchants/#{id}", params: merchant_params

    merchant = Merchant.find_by(id: id)
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(json_response[:data][:attributes][:name]).to eq(merchant.name)
  end
end