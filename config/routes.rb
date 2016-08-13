Rails.application.routes.draw do

  scope module: :web do

    root to: 'welcome#index'

    namespace :users, path: :user do

      root to: 'welcome#index'

      resources :tasks, except: [:index] do
        patch ':state' => 'tasks#change_state', on: :member, as: :change_state
      end

    end

  end

end
