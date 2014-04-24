module AngularBlog
  class Post < ActiveRecord::Base
    belongs_to :blogger, class_name: "Admin"

    has_many :comments, -> { order(created_at: :asc) }
    has_many :components, -> { order(index: :asc, created_at: :asc) }
    has_many :post_tags
    has_many :tags, through: :post_tags

    scope :visible, ->(current_admin){
      if current_admin.nil?
        posts = where(published: true).where.not(published_on: nil)
      elsif current_admin.is_super?
        posts = all
      elsif current_admin.is_blogger
        posts = visible_to_blogger(current_admin) 
      else
        posts = where(published: true).where.not(published_on: nil)
      end
      posts.order(published_on: :desc)
    }

    scope :visible_to_blogger, ->(admin) {
      where("angular_blog_posts.blogger_id = #{admin.id} OR angular_blog_posts.published = true")
    }

    def self.by_date year, month, day
      date = Date.new(year.to_i,month.to_i,day.to_i)
      where("published_on >= ?",date).where("published_on < ?",date + 1.day)
    end

    def publish publish_post=true
      if publish_post
        self.published = true
        self.published_on = Time.now
        self.permapath = self.default_permapath
      else
        self.published = false
        self.published_on = nil
        self.permapath = nil   
      end
    end

    def default_permapath
      if published && published_on
        path = published_on.strftime("%Y/%m/%d/") + subject.parameterize
        other_posts = Post.select(:id).where.not(id: id).where("permapath LIKE ?",path+"%")
        unless other_posts.blank?
          path += "-" + (other_posts.length+1).to_s
        end
        path
      end
    end

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
