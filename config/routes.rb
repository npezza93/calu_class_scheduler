Rails.application.routes.draw do

  get 'password_resets/new'

  controller :sessions do
   get 'login' => :new
   post 'login' => :create
   delete 'logout' => :destroy
  end

  get 'signup'  => 'users#new'
  resources :users, :except => :show

  resources :password_resets

  # You can have the root of your site routed with "root"
  root 'sessions#new'

  get "/user_options" => 'users#user_options', as: 'user_options'

end
