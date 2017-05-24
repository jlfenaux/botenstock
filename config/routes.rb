Rails.application.routes.draw do
  get "sitemap.xml.gz" => "sitemaps#sitemap", format: :xml, as: :sitemap
  get "/.well-known/acme-challenge/:id" => "homepage#letsencrypt"
  localized do
    devise_for :users
    get 'bot/:permalink' => 'directory#show', as: 'bot_page'
    resources :photos, only: [:index, :create, :destroy]
    resources :selected_bots
    get 'directory/:platform/:category/:language/(:keywords)' => 'directory#index', as: 'directory'
    resources :providers, :bots, :posts
    resources :contacts do
      member do
        put 'completed'
      end
    end
    get 'logos' => 'bots#logos'
    post 'posts/preview' => 'posts#preview', as: 'post_preview'
    get 'admin' => "admin#index", as: 'admin'
    get 'blog/:permalink' => 'blog#show', as: 'blog_article'
    get 'blog' => 'blog#index', as: 'blog'
    root to: 'homepage#index'
  end
end
