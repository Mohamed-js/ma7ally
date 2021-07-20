Rails.application.routes.draw do

  
  namespace :api do
    namespace :v1 do
      root "items#index"
      get "/trader-items", to: "traders#trader_items"
      get "/trader-categories", to: "traders#trader_categories"
      resources :orders
      resources :trader_categories
      resources :parents
      resources :categories
      resources :items
      resources :traders
      resources :users, only: %i[show create update]
      resources :sessions, only: :create
      
      resources :store, only: %i[index show]
      get "/:storename/items/:id", to: "store#show_item"

      resources :user_sessions, only: :create
      resources :carts
    end
  end
end
