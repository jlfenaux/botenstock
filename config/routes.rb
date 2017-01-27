Rails.application.routes.draw do
  devise_for :users
  localized do
    resources :bots
    get 'bots/:platform/:category/:language/(:keywords)' => 'bots#index', as: 'bot_directory'
    root to: 'homepage#index'
  end
  # root to: 'homepage#index'
end
