Job::Application.routes.draw do
  resources :topics do
    put :inbox,   :on => :member, :action => :put_inbox
    put :ignored, :on => :member, :action => :put_ignored
    put :cared,   :on => :member, :action => :put_cared

    get :inbox,   :on => :collection
    get :ignored, :on => :collection
    get :cared,   :on => :collection
  end

  root 'topics#inbox'
end
