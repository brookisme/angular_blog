module AngularBlog
  class Header < ActiveRecord::Base
    include AngularBlog::Postable

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
