Rails.application.routes.draw do
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  get '/search' => 'search#search'
  devise_for :users, :controllers => {
   :registrations => 'users/registrations',
  }
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  
    root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :books do
    
    resource :favorites, only: [:create, :destroy]
    
    resources :book_comments, only: [:create, :destroy]
  end
  

  

end