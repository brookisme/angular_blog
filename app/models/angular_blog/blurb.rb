module AngularBlog
  class Blurb < ActiveRecord::Base
    has_one :component, as: :postable, class_name: "AngularBlog::Component"

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
