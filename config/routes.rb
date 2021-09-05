# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'application#not_found'
  # Api definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create]
      resources :tokens, path: :login, only: [:create]
      resources :articles, only: %i[index show create destroy] do
        resources :comments, only: %i[show create destroy]
      end
    end
  end
end
