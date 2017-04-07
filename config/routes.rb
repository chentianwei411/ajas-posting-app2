Rails.application.routes.draw do
# verb, Url Pattern,  Controller#Action
  get "/jquery-1" => "pages#jquery_1"
  get "/jquery-2" => "pages#jquery_2"
  get "/jquery-3" => "pages#jquery_3"
  get "/jquery-4" => "pages#jquery_4"
  get "/jquery-5" => "pages#jquery_5"
  get "/jquery-6" => "pages#jquery_6"

  root "pages#jquery_1"
end
