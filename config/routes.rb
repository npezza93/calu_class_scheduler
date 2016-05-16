def warden(request)
  request.env['warden']
end

def user?(request)
  warden_req = warden(request)
  warden_req.authenticate? && !warden_req.user.advisor?
end

def advisor?(request)
  warden_req = warden(request)
  warden_req.authenticate? && warden_req.user.advisor?
end

Rails.application.routes.draw do
  resources :semesters, only: [:index, :new, :create] do
    collection do
      put :system
      put :set_session
    end
  end

  resources :curriculum_categories
  resources :majors

  resources :offerings do
    collection do
      post :import
    end
  end

  resources :courses

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    authenticated :user do
      root 'work_schedules#index', constraints: lambda{ |request| user?(request) }
      root 'users#index', constraints: lambda{ |request| advisor?(request) }
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :transcripts, only: [:index, :create, :destroy], path: :transcript do
    collection do
      post :import
    end
  end
  resources :work_schedules, only: [:create, :index, :destroy], path: :calendar
  resources :schedules, only: [:index, :create, :destroy], path: :schedule


  resources :users, only: :index do
    resources :schedule_approvals, only: [:create, :new, :edit, :update]
  end
end
