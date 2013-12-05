Job::Application.routes.draw do
  resources :topics do
    put :ignore,  :on => :member
    get :ignored, :on => :collection
  end
  root 'home#index'
end
