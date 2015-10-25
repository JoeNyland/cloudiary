Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root   'sessions#new'
  get    'signup'  => 'users#new'
  get    'account' => 'users#show'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  resources :users

end
