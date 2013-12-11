Job::Application.routes.draw do
  resources :topics do
    put :add_tag,    :on => :member
    put :remove_tag, :on => :member
    get :untaged,    :on => :collection
    get :search,     :on => :collection
  end

  resources :tags

  root 'tags#inbox'
end
