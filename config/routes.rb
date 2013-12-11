Job::Application.routes.draw do
  resources :topics do
    put :add_tag,    :on => :member
    put :remove_tag, :on => :member
  end

  resources :tags

  root 'topics#index'
end
