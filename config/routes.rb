Rails.application.routes.draw do
  root 'projects#inbox'
  resources :projects, except: :index do
    resources :tasks, except: :index
  end
  devise_for :users
end
