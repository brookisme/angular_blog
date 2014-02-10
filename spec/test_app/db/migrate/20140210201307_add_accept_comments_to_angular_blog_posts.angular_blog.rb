# This migration comes from angular_blog (originally 20140210201226)
class AddAcceptCommentsToAngularBlogPosts < ActiveRecord::Migration
  def change
    add_column :angular_blog_posts, :accept_comments, :boolean, default: true
  end
end
