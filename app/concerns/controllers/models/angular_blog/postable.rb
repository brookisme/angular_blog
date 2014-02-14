module AngularBlog
  module Postable
  extend ActiveSupport::Concern

    included do
      after_destroy :remove_relationship
      has_one :component, as: :postable, class_name: "AngularBlog::Component"
    end

  private

    def remove_relationship
      component = self.component
      unless  component.nil?
        component.postable = nil
        component.save
      end
    end
  end
end

