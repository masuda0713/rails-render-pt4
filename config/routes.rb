Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "static_pages#home"
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about' 
end
