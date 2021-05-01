Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
    root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
  end
  
end