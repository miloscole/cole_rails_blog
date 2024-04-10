Rails.application.routes.draw do
  root "welcome#home"

  resources :articles

  get "signup", to: "users#new", as: :new_user
  resources :users, path: "bloggers", except: %i[new]
end
