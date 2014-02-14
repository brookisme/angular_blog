module AngularBlog
  class Blurb < ActiveRecord::Base
    include AngularBlog::Postable

    def self.sizes
      [
        "tiny",
        "small",
        "normal",
        "large",
        "huge"
      ]
    end
  end
end
