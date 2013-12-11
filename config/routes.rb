Job::Application.routes.draw do
  resources :topics do
    put :tag,     :on => :member
    put :untag,   :on => :member

    put :inbox,   :on => :member, :action => :put_inbox
    put :ignored, :on => :member, :action => :put_ignored
    put :cared,   :on => :member, :action => :put_cared

    get :all,     :on => :collection
    get :ignored, :on => :collection
    get :cared,   :on => :collection
  end

  resources :tags

  root 'topics#index'
end
