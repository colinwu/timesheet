Rails.application.routes.draw do
  resources :expenses
  
  resources :invoices do
    member do
      get 'show_project'
      post 'project_new_or_add'
    end
  end
  
  resources :contacts
  
  resources :events do
    member do
      get 'start'
      get 'stop_now'
      get 'show_project'
    end
  end
  
  resources :projects do
    member do
      get 'stop'
    end
  end
  
  root :to => 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
