Rails.application.routes.draw do
  get 'change-calendar', to: 'tasks#change_calendar'
  root to: redirect('/today')
  get '/inbox', to: 'projects#inbox'
  get '/today', to: 'tasks#today'
  resources :projects, except: :index do
    get 'task_calendar', to: 'tasks#calendar'
    resources :tasks, except: :index
  end
  devise_for :users
end
