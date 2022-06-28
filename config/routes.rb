Rails.application.routes.draw do
  devise_for :users
  root 'projects#inbox'
  resources :projects, except: :index
end
