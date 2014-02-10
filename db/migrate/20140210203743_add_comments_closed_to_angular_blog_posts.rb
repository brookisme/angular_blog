class AddCommentsClosedToAngularBlogPosts < ActiveRecord::Migration
  def change
    add_column :angular_blog_posts, :comments_closed, :boolean
  end
end
