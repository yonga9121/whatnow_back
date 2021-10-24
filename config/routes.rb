Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do 
    
    namespace :users do 
      post  :signup
      post  :signin
      post  :complete_profile
      get   :profile

      resources :offers, only: [:index, :show] 

      resources :careers, only: [:index]

      resources :skills, only: [:index] do 
        collection do 
          get :soft
        end
      end 

      resources :colleges, only: [:index]
      
      resources :candidatures, only: [:index, :show]
    end 

    namespace :hunters do 
      post :signup
      post :signin
    end 

  end 
  
end
