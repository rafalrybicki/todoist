Rails.application.routes.draw do
  devise_for :users
  root 'projects#new'
  resources :projects, except: :index
end
