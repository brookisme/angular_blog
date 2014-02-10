class AddDefaultsToAngularBlog < ActiveRecord::Migration
  def up
    change_column :angular_blog_videos, :host, :string, default: 'youtube'
    change_column :angular_blog_blurbs, :size, :string, default: 'normal'
    change_column :angular_blog_headers, :size, :integer, default: 2
    change_column :angular_blog_images, :css_class, :string, default: 'ab-block-image'
  end
  def down
    change_column :angular_blog_videos, :host, :string
    change_column :angular_blog_blurbs, :size, :string
    change_column :angular_blog_headers, :size, :integer
    change_column :angular_blog_images, :css_class, :string
  end
end
