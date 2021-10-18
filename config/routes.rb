Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'pages#index'
    devise_for :users
    resources :tags, only: %i[show] do
      member do
        get 'follow'
        get 'unfollow'
      end
    end
    resources :profiles, only: %i[show] do
      member do
        get 'follow'
        get 'unfollow'
        get 'followers'
        get 'following'
      end
    end
    resources :pins do
      member do
        get 'like'
        get 'unlike'
      end
    end
  end
end
