module AngularBlog
  class Post < ActiveRecord::Base
    belongs_to :blogger, class_name: "SurveyBase::Admin"

    has_many :comments, -> { order(created_at: :asc) }
    has_many :components, -> { order(index: :asc, created_at: :asc) }
    has_many :post_tags
    has_many :tags, through: :post_tags  
  end
end
