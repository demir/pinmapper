Rails.application.routes.draw do
  get '/:sitemap', to:          'sitemaps#show',
                   constraints: { format: /xml/, sitemap: /sitemap-.+/ }
  require 'sidekiq/web'
  get '/robots.:format', to: 'pages#robots'
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resource :embed, only: :update
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    match '/404', to: 'errors#not_found', via: :all
    match '/500', to: 'errors#internal_server_error', via: :all

    unauthenticated do
      root 'explore#index'
    end

    authenticated :user do
      root 'pins#index', as: :authenticated_root
    end
    get 'terms_of_use' => 'pages#terms_of_use'
    get 'privacy_policy' => 'pages#privacy_policy'
    get 'about' => 'pages#about'
    get 'cookie_policy' => 'pages#cookie_policy'
    devise_for :users, skip: %i[registrations omniauth_callbacks]
    # devise/registrations#edit route'unu iptal etmek için aşağıdaki block eklendi
    as :user do
      get 'users/cancel' => 'devise/registrations#cancel', as: 'cancel_user_registration'
      get 'users/sign_up' => 'devise/registrations#new', as: 'new_user_registration'
      patch 'users' => 'devise/registrations#update', as: 'user_registration'
      put 'users' => 'devise/registrations#update'
      delete 'users' => 'devise/registrations#destroy'
      post 'users' => 'devise/registrations#create'
    end
    # search
    get 'search/pins'
    get 'search/boards'
    get 'search/users'
    # explore
    get 'explore/index'
    get 'explore/locations/:token' => 'explore#location', as: :explore_location
    # settings
    get 'settings/edit_profile'
    get 'settings/change_password'
    get 'settings/change_username'
    get 'settings/change_email'
    get 'settings/switch_locale'
    get 'settings/accept_cookies'
    namespace :settings do
      put 'profiles/update'
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
        patch 'move/:pin_id', action: 'move', as: 'move_pin'
        patch 'move_board_by_id'
        patch 'move_board_section/:board_section_id', action: 'move_board_section',
                                                      as:     'move_board_section'
        get 'add_to_board_section_list'
      end
      collection do
        get 'add_to_board_list/:pin_id', action: 'add_to_board_list', as: 'add_to_board_list'
        get 'following_boards'
      end
      resources :board_sections, shallow: true, except: %i[index] do
        member do
          get 'add_pin/:pin_id', action: 'add_pin', as: 'add_pin'
          get 'remove_pin/:pin_id', action: 'remove_pin', as: 'remove_pin'
          patch 'move'
          patch 'move_pin/:pin_id', action: 'move_pin', as: 'move_pin'
        end
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
        get 'boards_added_by_owner'
      end
      collection do
        get 'liked_pins'
      end
    end
  end
end
