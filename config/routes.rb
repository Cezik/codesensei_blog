Rails.application.routes.draw do
  devise_for :users
  # get '/', to: 'welcome#index'
  root to: 'articles#index'

  resources :articles do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :pictures
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
