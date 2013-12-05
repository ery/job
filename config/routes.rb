Job::Application.routes.draw do
  resources :topics do
    put :ignore,  :on => :member
    put :care,    :on => :member
    get :ignored, :on => :collection
    get :cared,   :on => :collection
    get :all,     :on => :collection
  end
  root 'home#index'
end
