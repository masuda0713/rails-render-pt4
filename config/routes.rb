Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root "static_pages#home"    # ルートURLにアクセス
  get  "/help",    to: "static_pages#help"    # helpページにアクセス
  get  "/about",   to: "static_pages#about"   # aboutページにアクセス
  get  "/contact", to: "static_pages#contact" # contactページにアクセス
end
