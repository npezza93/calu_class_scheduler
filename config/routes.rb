# frozen_string_literal: true
def user?(request)
  warden_req = request.env["warden"]
  warden_req.authenticate? && !warden_req.user.advisor?
end

def advisor?(request)
  warden_req = request.env["warden"]
  warden_req.authenticate? && warden_req.user.advisor?
end

Rails.application.routes.draw do
  resources :semesters, only: [:index, :new, :create, :update]

  resources :majors do
    resources :curriculum_categories, except: :index
  end

  resources :offerings do
    collection do
      post :import
    end
  end

  resources :courses

  devise_for :users, controllers: { registrations: "registrations" }
  devise_scope :user do
    authenticated :user do
      root "work_schedules#index", constraints: ->(request) { user?(request) }
      root "users#index", constraints: ->(request) { advisor?(request) }
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :transcripts, only: [:index, :create, :destroy],
                          path: :transcript do
    collection do
      post :import
    end
  end
  resources :work_schedules, only: [:create, :index, :destroy], path: :calendar
  resources :schedules, only: [:index, :create, :destroy], path: :schedule

  resources :users, only: :index do
    resources :schedule_approvals, only: [:create, :update]
  end
end
