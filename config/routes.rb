Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks',
   registrations: 'users/registrations'
   # 上３行：SNS認証機能に対して決まった記述
 }
 devise_scope :user do # 住所情報を登録させるページを表示するnew_homeアクションと住所情報を登録するcreate_homeアクションのルーティングを設定
  get 'homes', to: 'users/registrations#new_home'
  post 'homes', to: 'users/registrations#create_home'
end
  root to: "items#index"
  
  resources :items do
    resources :orders, only: [:index, :create] 
    resources :comments, only: :create
    collection do #商品複雑検索用item_searchアクションはitemがないと動かないからitemを親とした入れ子で記述
      get 'item_search'
    end
    collection do #逐次検索用searchアクションはitemがないと動かないからitemを親とした入れ子で記述
      get 'search'
    end
  end
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]

end
