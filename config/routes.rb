Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
    resources :comments
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
