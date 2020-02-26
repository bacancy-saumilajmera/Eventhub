Rails.application.routes.draw do
  root 'events#index'
   
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :events
  get 'my_event' , to: 'events#my_event'
  post 'show_interest' , to: 'events#show_interest'
  get 'interested_event' , to: 'events#interested_event'
  get 'event_requests' , to: 'events#event_requests'
  get 'event_accept/:id' , to: 'events#event_accept', as: 'event_accept'
  get 'event_reject/:id' , to: 'events#event_reject', as: 'event_reject'
  get 'interested_users/:id', to: 'events#interested_users', as: 'interested_users'
end
