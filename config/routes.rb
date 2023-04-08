Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :admin do
    root to: 'users#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index edit update show destroy]
    resources :wish_lists, only: %i[index edit update show destroy]
    resources :messages, only: %i[index edit update show destroy]
  end

  root 'static_pages#top'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]

  resources :password_resets, only: %i[new create edit update]

  resources :wish_lists, shallow: true do
    resources :items, only: %i[new create destroy]
    resources :messages, only: %i[new create destroy]
  end

  resource :mypage, only: %i[show edit update]
end
