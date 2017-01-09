Rails.application.routes.draw do
  resources :bots
  root to: 'visitors#index'
end
