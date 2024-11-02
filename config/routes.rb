Rails.application.routes.draw do
  # ルートパスの設定
  # GET / → tasks#index
  root 'tasks#index'

  # タスクのリソース設定
  # GET    /tasks          → tasks#index   (タスク一覧)
  # POST   /tasks          → tasks#create  (タスク作成)
  # PATCH  /tasks/:id      → tasks#update  (タスク更新)
  # DELETE /tasks/:id      → tasks#destroy (タスク削除)
  # PATCH  /tasks/:id/toggle → tasks#toggle (タスク完了状態の切り替え)
  resources :tasks, only: [:index, :create, :update, :destroy] do
    member do
      patch :toggle
    end
  end

  # ヘルスチェック用のルート
  get "up" => "rails/health#show", as: :rails_health_check
end
