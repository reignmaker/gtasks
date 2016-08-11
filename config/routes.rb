Rails.application.routes.draw do

  scope module: :web do
    root 'welcome#index'
    resources :tasks
    resources :users, only: [] do
      collection do
        scope module: :users do
          resources :tasks, only: [:index], as: :user_tasks
        end
      end
    end
  end

end
