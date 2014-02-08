AngularBlog::Engine.routes.draw do
  scope :templates do
    get ':path.html' => 'application#template', :constraints => { :path => /.+/  }
  end
end
