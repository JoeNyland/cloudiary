Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get    'signup'  => 'users#new'
  get    'account' => 'users#show'
  resources :users

end
