Rails.application.routes.draw do

  root 'pages#index'
  get 'top', to: 'pages#top'
  get '/login/index', to: 'sessions#index'
  # ユーザーログイン
  get '/user/login',   to: 'sessions#user_new'
  post '/user/login',   to: 'sessions#user_create'
  # ティーチャーログイン
  get '/teacher/login',   to: 'sessions#teacher_new'
  post '/teacher/login',   to: 'sessions#teacher_create'
  # ログアウト
  delete '/logout',  to: 'sessions#destroy'
  # いいね機能
  get '/likes', to: 'likes#index'
  post '/likes', to: 'likes#create'
  delete '/unlike', to: 'likes#destroy'

  resources :users
  resources :requets
  resources :teachers
  resources :topics
  resources :chats
  resources :reviews


end
