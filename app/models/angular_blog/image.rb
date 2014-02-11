module AngularBlog
  class Image < ActiveRecord::Base
    has_one :component, as: :postable, class_name: "AngularBlog::Component"
  end
end
