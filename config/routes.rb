Rails.application.routes.draw do
  root to: redirect('/today')
  get '/inbox', to: 'projects#inbox'
  get '/today', to: 'tasks#today'
  resources :projects, except: :index do
    resources :tasks, except: %i[index show]
  end
  devise_for :users
end
