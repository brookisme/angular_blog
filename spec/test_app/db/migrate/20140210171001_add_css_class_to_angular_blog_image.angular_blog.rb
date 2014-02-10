# This migration comes from angular_blog (originally 20140210170124)
class AddCssClassToAngularBlogImage < ActiveRecord::Migration
  def change
    add_column :angular_blog_images, :css_class, :string
  end
end
