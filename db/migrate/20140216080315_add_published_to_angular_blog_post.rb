class AddPublishedToAngularBlogPost < ActiveRecord::Migration
  def change
    add_column :angular_blog_posts, :published, :boolean
    add_column :angular_blog_posts, :published_on, :timestamp
  end
end
