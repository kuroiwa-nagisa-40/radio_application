Rails.application.routes.draw do
  root 'programs#index'
  resources :programs

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
