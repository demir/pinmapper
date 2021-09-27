Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'pages#index'
    devise_for :users
    get 'profiles/:id', to: 'profiles#show', as: 'profile'
    resources :pins do
      member do
        get 'like'
        get 'unlike'
      end
    end
  end
end
