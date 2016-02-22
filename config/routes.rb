Rails.application.routes.draw do
  resources :semesters, only: [:index, :new, :create] do
    collection do
      put :system
      put :set_session
    end
  end

  resources :curriculum_categories

  resources :majors, except: :new

  resources :offerings do
    collection do
      post :import
    end
  end

  resources :courses

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    authenticated :user do
      root 'schedules#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: :index do
    resources :transcripts, only: [:index, :create, :destroy] do
      collection do
        post :import
      end
    end
    resources :schedules, only: [:index, :create, :new, :destroy]
    resources :schedule_approvals, only: [:create, :new, :edit, :update]
    resources :work_schedules, only: [:create, :new, :index, :destroy]
  end
end
