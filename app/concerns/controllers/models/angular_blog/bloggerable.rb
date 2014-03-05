module AngularBlog
  module Bloggerable
  extend ActiveSupport::Concern
    included do
      has_many :posts, class_name: "AngularBlog::Post", foreign_key: "blogger_id"
    end

    def display_name
      (first_name.to_s + " " + last_name).to_s.titleize
    end
  end
end
