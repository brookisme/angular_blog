module AngularBlog
  class Image < ActiveRecord::Base
    include AngularBlog::Postable
  end
end
