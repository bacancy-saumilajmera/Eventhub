# frozen_string_literal: true

Rails.application.routes.draw do
  root 'events#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :events
  # resources :charges
  get 'charges/:id', to: 'charges#new', as:'charges'
  post 'charges/:id', to: 'charges#create', as:'charges_pay'
  get 'messages/:id', to: 'messages#new', as: 'messages_send'
  post 'messages/:id', to: 'messages#create'
  get 'registered_messages/:id', to: 'registered_messages#new', as: 'registered_messages_send'
  post 'registered_messages/:id', to: 'registered_messages#create'
  get 'my_event', to: 'events#my_event'
  get 'show_details/:id', to: 'events#show_details', as: 'show_details'
  post 'show_interest', to: 'events#show_interest'
  get 'registered_events', to: 'events#registered_events'
  get 'event_requests', to: 'events#event_requests'
  get 'event_accept/:id', to: 'events#event_accept', as: 'event_accept'
  get 'event_reject/:id', to: 'events#event_reject', as: 'event_reject'
  get 'interested_users/:id', to: 'events#interested_users', as: 'interested_users'
  get 'registered_users/:id', to: 'events#registered_users', as: 'registered_users'
  post 'post_comment/:id', to: 'events#post_comment', as: 'post_comment'
  get 'registration_form/:id', to: 'events#registration_form', as: 'registration_form'
  post 'register/:id', to: 'events#register', as: 'register'
  get 'notifications', to: 'notifications#show_notifications', as: 'notification'
  get 'receipt/:id/', to: 'events#show_receipt', as: 'receipt'
  get 'all_users', to: 'users#all_users', as: 'all_users'
  get 'add_role_admin/:id', to: 'users#add_admin_role', as: 'add_role_admin'
  get 'remove_role_admin/:id', to: 'users#remove_admin_role', as: 'remove_role_admin'
end
