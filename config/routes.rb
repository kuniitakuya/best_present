Rails.application.routes.draw do
  get 'items/search'
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resource :mypage, only: %i[show edit update]
  resources :wish_lists, only: %i[index new create]
end
