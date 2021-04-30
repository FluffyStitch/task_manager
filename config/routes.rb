Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root 'projects#index'
  resources :projects, except: %i[index show] do
    resources :tasks, shallow: true, except: %i[index show] do
      put 'reprioritate', to: 'tasks#reprioritate'
      put 'complete', to: 'tasks#complete'
    end
  end
end
