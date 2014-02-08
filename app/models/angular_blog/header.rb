module AngularBlog
  class Header < ActiveRecord::Base
    has_one :component, as: :postable, class_name: "AngularBlog::Component"
  end
end
