# This migration comes from angular_blog (originally 20140210171459)
class ChangeComponentDimensionsToStrings < ActiveRecord::Migration
  def up
    change_column :angular_blog_components, :width, :string
    change_column :angular_blog_components, :height, :string
  end
  
  def down
    change_column :angular_blog_components, :width, :integer
    change_column :angular_blog_components, :height, :integer
  end
end
