Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root 'lists#index'
  resources :lists do
    member do
      get :generate_labels
      get :preview_contacts
      post :upload_contacts
    end
    resources :contacts, only: [:new, :create, :edit, :update, :destroy]
  end
end
