Job::Application.routes.draw do
  get 'topics' => 'topics#index'

  resources :subjects do
    put :putinbox, :on => :member
    put :ignore,   :on => :member
    put :care,     :on => :member
    get :inbox,    :on => :collection
    get :ignored,  :on => :collection
    get :cared,    :on => :collection
  end

  root 'subjects#inbox'
end
