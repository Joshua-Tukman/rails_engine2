Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get '/revenue', to: 'revenue#show'
      namespace :items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :items, except: [ :new, :edit ] do
        get 'merchant', to: 'merchant_items#show'
      end

      namespace :merchants do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'most_items_sold#index'
      end
  
      resources :merchants, except: [ :new, :edit ] do
        get '/items', to: 'merchant_items#index'
      end
    end
  end
end
