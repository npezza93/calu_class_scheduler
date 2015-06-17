Rails.application.routes.draw do
  
  resources :semesters, only: [:index, :new, :create, :update]

  resources :curriculum_categories, except: :show do
    resources :curriculum_category_sets do
      resources :course_sets, only: [:new, :create, :destroy]
    end
  end

  resources :majors

  resources :offerings do
    collection { post :import}
  end

  resources :courses

  controller :sessions do
   get 'login' => :new
   post 'login' => :create
   delete 'logout' => :destroy
  end

  get 'signup'  => 'users#new'
  
  resources :users, :except => :show do
    resources :transcripts, :only => [:index, :create, :destroy] do
      collection { post :import}
    end
    resources :schedules, :only => [:index, :create, :new, :destroy]
    resources :schedule_approvals, :only => [:create, :new, :edit, :update]
    resources :work_schedules, only: [:create, :new, :index, :destroy]
  end

  resources :password_resets
  
  root 'sessions#new'
end
