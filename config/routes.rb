Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "buildings#index"

  get "/buildings", to: "buildings#index", as: "buildings_index"

  resources :clients do
    member do
      get 'read_buildings'
      post 'create_building'
      patch 'edit_building'
    end
  end
end
