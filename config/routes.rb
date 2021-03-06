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
  resources :semesters, only: :update

  resources :majors do
    resources :curriculum_categories, except: :index
  end

  resources :courses do
    resources :offerings, except: :show
  end

  namespace :offerings do
    post :import
  end

  devise_for :users, controllers: {
    registrations: :registrations, sessions: :sessions
  }
  devise_scope :user do
    authenticated :user do
      root "work_schedules#index", constraints: ->(request) { user?(request) }
      root "users#index", constraints: ->(request) { advisor?(request) }
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :transcripts, only: %i(index create destroy new),
                          path: :transcript
  resources :work_schedules, only: %i(create index destroy), path: :calendar
  resources :schedules, only: %i(index create destroy), path: :schedule

  resources :users, only: %i(index show) do
    resources :schedule_approvals, only: %i(create update)
  end
end
