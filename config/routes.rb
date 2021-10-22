Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'pages#index'
    devise_for :users
    resources :boards
    resources :tags, only: %i[show] do
      member do
        get 'follow'
        get 'unfollow'
      end
      collection do
        get 'following_tags'
      end
    end
    resources :profiles, only: %i[show] do
      member do
        get 'follow'
        get 'unfollow'
        get 'followers'
        get 'following'
        get 'boards'
      end
    end
    resources :pins do
      member do
        get 'like'
        get 'unlike'
      end
      collection do
        get 'liked_pins'
      end
    end
  end
end
