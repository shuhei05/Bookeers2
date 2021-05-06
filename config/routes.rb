Rails.application.routes.draw do
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  get '/search' => 'search#search'
  devise_for :users, :controllers => {
   :registrations => 'users/registrations',
  }
  resources :users,only: [:show,:index,:edit,:update] do
    member do
     get :followings, :followers
    end
  end
  
    root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :books do
    
    resource :favorites, only: [:create, :destroy]
    
    resources :book_comments, only: [:create, :destroy]
  end
  
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  

end