Rails.application.routes.draw do
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"

  get 'signup' => 'users#new'
  get '/users/new'
  get "users/:id" => "users#show"
  resources :diaries
  resources :diaries do
  collection do
    post :index
  end
end
  get '/' => 'home#top'
  get 'about' => 'home#about'
end