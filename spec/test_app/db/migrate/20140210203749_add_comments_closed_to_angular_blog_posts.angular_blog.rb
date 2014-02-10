# This migration comes from angular_blog (originally 20140210203743)
class AddCommentsClosedToAngularBlogPosts < ActiveRecord::Migration
  def change
    add_column :angular_blog_posts, :comments_closed, :boolean
  end
end
