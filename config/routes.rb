Rails.application.routes.draw do
  root to: 'api/v1/movies#index'
  namespace :api do
    namespace :v1 do
      resources :movies
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
