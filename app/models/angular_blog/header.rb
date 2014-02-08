module AngularBlog
  class Header < ActiveRecord::Base
    has_one :component, as: :postable, class_name: "AngularBlog::Component"

    def self.sizes
      [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6"
      ]
    end
  end
end
