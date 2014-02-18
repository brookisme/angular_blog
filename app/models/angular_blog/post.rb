module AngularBlog
  class Post < ActiveRecord::Base
    belongs_to :blogger, class_name: "SurveyBase::Admin"

    has_many :comments, -> { order(created_at: :asc) }
    has_many :components, -> { order(index: :asc, created_at: :asc) }
    has_many :post_tags
    has_many :tags, through: :post_tags

    scope :visible, ->(current_admin,timestamp=nil){
      if current_admin.nil?
        posts = where(published: true)
      elsif current_admin.is_super?
        posts = all
      elsif current_admin.is_blogger
        posts = visible_to_blogger(current_admin) 
      else
        posts = where(published: true)
      end
      posts.order(created_at: :desc)
    }

    scope :visible_to_blogger, ->(admin) {
      where("angular_blog_posts.blogger_id = #{admin.id} OR angular_blog_posts.published = true")
    }

    def text_content 
      content = ""
      components.each do |component|
        if (component.type == "Blurb" || component.type == "Header") && !component.postable.nil?
          content += component.postable.content
        end
      end
      content
    end
  end
end
