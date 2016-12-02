Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :events do
    resources :event_items
    resources :participations
    member do
      get :payment_summary
    end
  end

  root "home#index"
  get "confirmation/:user_id", to: "home#confirmation", as: "confirmation_user"
  get "payment_summary", to: "home#payment_summary", as: "payment_summary_home"
  post "confirm", to: "home#confirm", as: "confirm_user"
end
