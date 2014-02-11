module AngularBlog
  class ApplicationController < ActionController::Base
    include AngularBlog::Angularable
  end
end