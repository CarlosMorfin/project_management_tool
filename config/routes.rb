Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    root 'users/sessions#new'
    get 'email_confirmation', to: 'users/sessions#redirect_from_magic_link'
    post 'sign_in_with_token', to: 'users/sessions#sign_in_with_token'
  end
end
