Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "homes#show"
  namespace :my do
    resource :dashboards, only: :show
  end
end
