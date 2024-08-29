Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :clients do
    member do
      get 'read_buildings'
      post 'create_building'
      put 'edit_building'
    end
  end
end
