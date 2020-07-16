require 'rails_helper'

RSpec.describe "Search API" do
  it 'can find a list of merchants that contain a fragment, case insensitive' do
    create(:merchant, name: "Turing")
    create(:merchant, name: "Enduring")
    create(:merchant, name: "Bob")
    create(:merchant, name: "Sue")
    create(:merchant, name: "Curing")
    create(:merchant, name: "Annie")
    create(:merchant, name: "Josh")

    search_params = { name: "URING" }

    get "/api/v1/merchants/find_all" , params: search_params

    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(json_response[:data].count).to eq(3)
  end

   it 'can find a merchants that contain a fragment, case insensitive' do
    create(:merchant, name: "Turing")
    create(:merchant, name: "Enduring")
    create(:merchant, name: "Bob")
    create(:merchant, name: "Sue")
    create(:merchant, name: "Curing")
    create(:merchant, name: "Annie")
    create(:merchant, name: "Josh")

    search_params = { name: "URING" }

    get "/api/v1/merchants/find" , params: search_params

    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(json_response[:data][:attributes][:name]).to eq("Turing")

   end
   
   it 'can find a list of items that contain a fragment, case insensitive' do
     merchant = create(:merchant)
     merchant2 = create(:merchant)

     create(:item, name: "Josh", merchant_id: merchant.id)
     create(:item, name: "Curing", merchant_id: merchant.id)
     create(:item, name: "Sue", merchant_id: merchant.id)
     create(:item, name: "Bob", merchant_id: merchant.id)
     create(:item, name: "Turing", merchant_id: merchant.id, description: "blue")

     create(:item, name: "Enduring", merchant_id: merchant2.id)
     create(:item, name: "Coors", merchant_id: merchant2.id)
     create(:item, name: "Budweiser", merchant_id: merchant2.id)

     search_params = { name: "URING" }

     get "/api/v1/items/find_all" , params: search_params
    
     expect(response).to be_successful

     json_response = JSON.parse(response.body, symbolize_names: true)
     
     expect(json_response[:data].count).to eq(3)
   end
end