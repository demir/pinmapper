Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'pages#index'
    devise_for :users
  end
end
