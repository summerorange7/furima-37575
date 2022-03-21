Rails.application.routes.draw do
  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks',
   registrations: 'users/registrations'
   # 上３行：SNS認証機能に対して決まった記述
 }
  root to: "items#index"
  
  resources :items do
    resources :orders, only: [:index, :create] 
  end
end
