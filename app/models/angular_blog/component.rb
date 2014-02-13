module AngularBlog
  class Component < ActiveRecord::Base
    belongs_to :post
    belongs_to :postable, polymorphic: true

    def type
      unless postable_type.nil?
        postable_type.gsub("AngularBlog::","").capitalize
      end
    end
  end
end
