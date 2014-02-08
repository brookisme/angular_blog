module AngularBlog
  class Component < ActiveRecord::Base
    belongs_to :post
    belongs_to :postable, polymorphic: true

    def type
      unless postable.nil?
        postable_type.gsub("AngularBlog::","").downcase
      end
    end
  end
end
