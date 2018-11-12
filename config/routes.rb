# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'api/v1/movies#index'
  devise_for :users,
             path: 'auth',
             path_names: { sign_in: 'login', sign_out: 'logout' },
             controllers: { sessions: :sessions, registrations: :registrations }
  namespace :api do
    namespace :v1 do
      resources :movies
      resources :categories, only: %i[index]
      resources :users, only: %i[index show] do
        resources :loans
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
