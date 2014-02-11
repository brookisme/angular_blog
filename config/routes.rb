AngularBlog::Engine.routes.draw do
  root to: 'posts#index'
  scope :templates do
    get ':path.html' => 'application#template', :constraints => { :path => /.+/  }
  end

  resources :posts
  resources :comments
  resources :components
  resources :headers
  resources :blurbs
  resources :images
  resources :videos
  resources :tags
end
