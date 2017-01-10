Rails.application.routes.draw do
  devise_for :users
  resources :bots
  get 'annuaire/:platform/:category/(:keywords)' => 'bots#index', as: 'bot_directory', defaults: {category: 'toutes_les_catégories', platform: 'toutes_les_plateformes'}
  root to: 'bots#index'

end
