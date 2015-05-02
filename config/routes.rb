Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :locations, only: [ :create ] do
        collection do
          get :route
        end
      end
    end
  end
end
