Rails.application.routes.draw do
  # ヘルスチェック用エンドポイント
  get '/health', to: proc { [200, {}, ['OK']] }
end
