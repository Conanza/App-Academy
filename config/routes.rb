Rails.application.routes.draw do
  root to: redirect("/subs")
  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :subs
  resources :posts, except: :index
end
