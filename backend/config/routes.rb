# config/routes.rb
Rails.application.routes.draw do
  # ヘルスチェック用エンドポイント
  get '/health', to: proc { [200, {}, ['OK']] }

  # API routes
  namespace :api do
    namespace :v1 do
      resources :quizzes do
        resources :questions, only: [:index, :show, :create, :update, :destroy] do
          resources :choices, only: [:index, :show, :create, :update, :destroy]
        end
      end

      resources :challengers do
        collection do
          get 'ranking'
        end
        resources :answers, only: [:index, :create, :destroy]
      end

      resources :choices, only: [] do
        resources :answers, only: [:index]
      end
    end
  end
end
