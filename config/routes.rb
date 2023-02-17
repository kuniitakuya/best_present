Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :wish_lists do
    resources :items, only: %i[new create destroy]
    resources :messages, only: %i[new create destroy]
  end
  resource :mypage, only: %i[show edit update]

end
