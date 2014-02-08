module AngularBlog
  class Component < ActiveRecord::Base
    belongs_to :post
    belongs_to :postable, polymorphic: true
  end
end
