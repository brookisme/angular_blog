# This migration comes from angular_blog (originally 20140210174948)
class AddDisplaySubjectToAngularBlogPost < ActiveRecord::Migration
  def change
    add_column :angular_blog_posts, :display_subject, :boolean, default: true
  end
end
