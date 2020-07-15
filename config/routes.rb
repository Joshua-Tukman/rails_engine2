Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/customers', to: 'customers#index'
  namespace :api do
    namespace :v1 do
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
      end
      

      resources :merchants, except: [ :new, :edit ] do
        get '/items', to: 'merchant_items#index'
      end
    end
  end
end
