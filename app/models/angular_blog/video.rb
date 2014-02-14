module AngularBlog
  class Video < ActiveRecord::Base
    include AngularBlog::Postable
  end
end
