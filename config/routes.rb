Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'admin/surveys#index'
  namespace :admin do
    resources :surveys, only: [:new, :create, :index, :show] do
      post 'questiontype', on: :member
      get 'results', on: :member
      resources :questions, only: [:new, :create, :destroy]
    end
  end
  resources :surveys, only: [:show] do
    resources :responses, only: [:new, :create]
  end
end
