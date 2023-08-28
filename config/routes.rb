Rails.application.routes.draw do
  # get 'accounts/show'
  resources :accounts, only: [:new, :create, :show]
  resources :transactions, only: [:new, :create, :index]

  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:create]
  # get 'user/account', to: 'user_accounts#show', as: :user_account
  # get 'admin/account', to: 'admin_accounts#show', as: :admin_account
  # get 'superadmin/account', to: 'superadmin_accounts#show', as: :superadmin_account
  root 'pages#home' 
end
