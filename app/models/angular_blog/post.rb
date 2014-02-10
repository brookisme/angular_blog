module AngularBlog
  class Post < ActiveRecord::Base
    has_many :comments, -> { order(created_at: :desc) }
    has_many :components, -> { order(index: :asc, created_at: :asc) }
    has_many :post_tags
    has_many :tags, through: :post_tags  
  end
end
