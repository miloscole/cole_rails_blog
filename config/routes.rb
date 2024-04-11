Rails.application.routes.draw do
  root "welcome#home"

  resources :articles

  get "signup", to: "users#new", as: :new_user
  resources :users, path: "bloggers", except: %i[new]

  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  delete "signin", to: "sessions#destroy"

  resources :categories
end
