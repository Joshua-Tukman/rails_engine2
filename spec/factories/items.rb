FactoryBot.define do
  factory :item do
    name { "Bones Brigade" }
    description { "The only skateboard you'll ever need!" }
    unit_price { 19.99 }
    merchant { nil }
  end
end
