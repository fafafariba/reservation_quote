Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#root"

  defaults format: :json do
    resources :day_prices, only: [:index, :create, :show]
    resources :inquiries, only: [:index, :create, :show]
    resources :units, only: [:index, :show]
  end
end
