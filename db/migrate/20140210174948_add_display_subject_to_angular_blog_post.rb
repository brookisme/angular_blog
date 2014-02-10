class AddDisplaySubjectToAngularBlogPost < ActiveRecord::Migration
  def change
    add_column :angular_blog_posts, :display_subject, :boolean, default: true
  end
end
