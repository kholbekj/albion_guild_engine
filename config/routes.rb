Rails.application.routes.draw do
  resources :events
  root to: 'home#show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Thredded::Engine => '/forum'
  resources :users, only: [:show]
  resources :events
  get '/calendar', to: 'home#calendar'

end
