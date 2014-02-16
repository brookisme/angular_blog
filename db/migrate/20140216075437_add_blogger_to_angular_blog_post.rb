class AddBloggerToAngularBlogPost < ActiveRecord::Migration
  def change
    add_reference :angular_blog_posts, :blogger, index: true
  end
end
