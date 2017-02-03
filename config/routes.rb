Rails.application.routes.draw do
  devise_for :users
  localized do
    get 'bot/:permalink' => 'directory#show', as: 'bot_page'
    get 'directory/:platform/:category/:language/(:keywords)' => 'directory#index', default:{platform: :all, language: :all, cateogry: :all}, as: 'directory'
    resources :providers, :bots
    root to: 'homepage#index'
  end
  # root to: 'homepage#index'
end
