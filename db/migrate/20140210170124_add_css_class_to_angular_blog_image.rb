class AddCssClassToAngularBlogImage < ActiveRecord::Migration
  def change
    add_column :angular_blog_images, :css_class, :string
  end
end
