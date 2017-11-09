Rails.application.routes.draw do
  mount_ember_app :frontend, to: '/'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: 'api' do
    namespace :v1 do
      resources :users
      resources :study_hours
      post 'study_hours/:id/mark_as_started', to: 'study_hours#mark_as_started'
      post 'study_hours/:id/mark_as_finished', to: 'study_hours#mark_as_finished'
    end
  end
end
