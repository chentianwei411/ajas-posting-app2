Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :posts do
    member do
      post "like" => "posts#like"
      post "unlike" => "posts#unlike"
      post "toggle_flag" => "posts#toggle_flag"
      
      post "collect" => "posts#collect"
      post "uncollect" => "posts#uncollect"
    end
    collection do
      get "my_likes" => "posts#my_likes"
      get "my_collections" => "posts#my_collections"
    end
  end
  # resources :collections

  namespace :account do
    resources :posts
  end
# verb, Url Pattern,  Controller#Action
  get "/jquery-1" => "pages#jquery_1"
  get "/jquery-2" => "pages#jquery_2"
  get "/jquery-3" => "pages#jquery_3"
  get "/jquery-4" => "pages#jquery_4"
  get "/jquery-5" => "pages#jquery_5"
  get "/jquery-6" => "pages#j"


end
