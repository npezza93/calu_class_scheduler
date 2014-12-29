Rails.application.routes.draw do

  resources :offerings do
    collection { post :import}
  end

  resources :courses, path: 'courses', :only => [:create, :new, :destroy, :index]

  controller :sessions do
   get 'login' => :new
   post 'login' => :create
   delete 'logout' => :destroy
  end

  get 'signup'  => 'users#new'
  
  resources :users, :except => :show do
    resources :transcripts, :only => [:index, :create]
  end

  resources :password_resets
  
  root 'sessions#new'

  get "/user_options" => 'users#user_options', as: 'user_options'

end
