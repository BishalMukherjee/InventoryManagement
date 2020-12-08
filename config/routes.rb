Rails.application.routes.draw do
  root "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get "auth/google_oauth2/callback", to: "session#create"

  delete "sign_out", to: "session#destroy"

  resources :categories, :brands, except: [:show, :edit, :update]

  resources :storages, except: [:show]

  resources :issues, :employees, :admins

  resources :items do
    member do 
      get "document"
    end
  end

  resources :notifications, only: [:index, :destroy] do
    collection do
      post "mark_as_read"
    end
  end

  get "notifications/clear/table", to: "notifications#clear_table"
end
