Rails.application.routes.draw do
  devise_for :users
  localized do
    get 'bot/:permalink' => 'directory#show', as: 'bot_page'
    get 'directory/:platform/:category/:language/(:keywords)' => 'directory#index', as: 'directory'
    resources :providers, :bots, :posts
    get 'admin' => "admin#index", as: 'admin'
    get 'blog/:permalink' => 'blog#show', as: 'blog_article'
    get 'blog' => 'blog#index', as: 'blog'
    root to: 'homepage#index'
  end
end
