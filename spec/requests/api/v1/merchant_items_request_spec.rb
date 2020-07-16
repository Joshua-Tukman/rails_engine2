require 'rails_helper'

RSpec.describe "Merchant items API" do
  it "can give a list of all items for one merchant" do
     merchant = create(:merchant)
     merchant2 = create(:merchant)
     create_list(:item, 10, merchant_id: merchant.id)
     create_list(:item, 20, merchant_id: merchant2.id)
  
     get "/api/v1/merchants/#{merchant.id}/items"

     expect(response).to be_successful

     items = JSON.parse(response.body, symbolize_names: true)
     expect(items[:data].count).to eq(10)
  end

  it "can get a merchant that sells that item" do
    merchant = create(:merchant)
    merchant2 = create(:merchant) 
    item = create(:item, merchant_id: merchant.id)
    wrong_items = create_list(:item, 10, merchant_id: merchant2.id)
   
    get "/api/v1/items/#{item.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant[:data][:id].to_i).to eq(item.merchant_id)
  end
end