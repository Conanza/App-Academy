Rails.application.routes.draw do
  root "static_pages#home"
  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :subs

  resources :posts, except: :index do
    resources :votes, only: :create
    resources :comments, only: :new
  end

  resources :comments, only: [:create, :show] do
    resources :votes, only: :create
  end

  get "/contact" => "static_pages#contact"
  get "/about" => "static_pages#about"
end
