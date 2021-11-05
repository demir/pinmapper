Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'pages#index'
    devise_for :users, skip: [:registrations]
    # devise/registrations#edit route'unu iptal etmek için aşağıdaki block eklendi
    as :user do
      get 'users/cancel' => 'devise/registrations#cancel', as: 'cancel_user_registration'
      get 'users/sign_up' => 'devise/registrations#new', as: 'new_user_registration'
      patch 'users' => 'devise/registrations#update', as: 'user_registration'
      put 'users' => 'devise/registrations#update'
      delete 'users' => 'devise/registrations#destroy'
      post 'users' => 'devise/registrations#create'
    end
    get 'settings/change_password'
    get 'settings/change_username'
    get 'settings/change_email'
    namespace :settings do
      put 'users/change_password'
      put 'users/change_username'
      put 'users/change_email'
    end
    resources :boards do
      member do
        get 'add_pin/:pin_id', action: 'add_pin', as: 'add_pin'
        get 'remove_pin/:pin_id', action: 'remove_pin', as: 'remove_pin'
        get 'follow'
        get 'unfollow'
      end
      collection do
        get 'add_to_board_list/:pin_id', action: 'add_to_board_list', as: 'add_to_board_list'
        get 'following_boards'
      end
    end
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
