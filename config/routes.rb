TesisArduino::Application.routes.draw do
  
  post 'main/login', :as => :login
  get 'main/logout', :as => :logout
  
  get 'users/index', :as => :dashboard
  get 'users/list', :as => :users_list
  resources :users
  
  resources :profiles
  
  resources :sensor_groups
  resources :sensors do
    match '/value/:value', :action => :change_value, :on => :member, :as => "change"
    post 'arduino_render', :on => :member
  end
  
  namespace :alerts do
    get 'turn_off_main_alarm'
  end
  resources :alerts do
    post 'arduino_render', :on => :member
  end
  
  root :to => 'main#index'
end
