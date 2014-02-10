class AddDisplayEmailToAngularBlogComments < ActiveRecord::Migration
  def change
    add_column :angular_blog_comments, :display_email, :boolean
  end
end
