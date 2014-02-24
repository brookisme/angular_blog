class AddPermapathToAngularBlogPost < ActiveRecord::Migration
  def change
    add_column :angular_blog_posts, :permapath, :string
    add_index :angular_blog_posts, :permapath, unique: true
  end
end
