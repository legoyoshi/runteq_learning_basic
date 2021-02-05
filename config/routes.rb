Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
  root    'static_pages#top'
  get     '/login',     to: 'user_sessions#new'
  post    '/login',     to: 'user_sessions#create'
  delete  '/logout',    to: 'user_sessions#destroy'
  resources :password_resets, only: %i[new create edit update]
  resources :users, only: %i[new create]
  resource :profile
  resources :boards do
    resources :comments, only: %i[create destroy], shallow: true
    resource :bookmarks, only: %i[create destroy]
    collection do
      get 'bookmarks'
    end
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
