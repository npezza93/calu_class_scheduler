class RoleConstraint
  def initialize(role)
    @role = role
  end

  def matches?(request)
    return true if @role == :advisor && request.env['warden'].user && request.env['warden'].user.advisor?
    return true if @role == :user && request.env['warden'].user && !request.env['warden'].user.advisor?

    false
  end
end

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
      root 'work_schedules#index', constraints: RoleConstraint.new(:user)
      root 'users#index', constraints: RoleConstraint.new(:advisor)
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
  resources :work_schedules, only: [:create, :new, :index, :destroy], path: :calendar do
    collection do
      post :create_day
      post :create_time
    end
  end
  resources :schedules, only: [:index, :create, :destroy], path: :schedule


  resources :users, only: :index do
    resources :schedule_approvals, only: [:create, :new, :edit, :update]
  end
end
