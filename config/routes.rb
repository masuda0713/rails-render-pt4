Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  # 静的ページのルーティング
  root "static_pages#home"                    # ルートURLにアクセス
  get  "/help",    to: "static_pages#help"    # helpページにアクセス
  get  "/about",   to: "static_pages#about"   # aboutページにアクセス
  get  "/contact", to: "static_pages#contact" # contactページにアクセス

  # Devise のルーティング設定（カスタムコントローラー & カスタムURL）
  devise_for :users, controllers: {
    registrations: 'users/registrations',  # カスタムユーザー登録コントローラー
    sessions: 'users/sessions'             # カスタムログインコントローラー
  }, path: '', path_names: { 
    sign_up: 'signup',  # /signup で新規登録
    sign_in: 'login',   # /login でログイン
    sign_out: 'logout'  # /logout でログアウト
  }


  # ユーザー一覧 & プロフィール（一般的に管理者のみ `index` を利用）
  resources :users, only: [:index,  # ユーザー一覧ページにアクセス
                           :show]   # ユーザー詳細ページにアクセス
end
