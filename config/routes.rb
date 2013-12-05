Job::Application.routes.draw do
  resources :topics
  root 'home#index'
end
