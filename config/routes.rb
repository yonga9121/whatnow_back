Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do 
    
    namespace :users do 
      post :signup
      post :signin
      post :complete_profile

      resources :offers, only: [:index, :show] do 
      end 
    end 

    namespace :hunters do 
      post :signup
      post :signin
    end 

  end 
  
end
