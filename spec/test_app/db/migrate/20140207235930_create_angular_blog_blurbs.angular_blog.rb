# This migration comes from angular_blog (originally 20140207222704)
class CreateAngularBlogBlurbs < ActiveRecord::Migration
  def change
    create_table :angular_blog_blurbs do |t|
      t.text :content
      t.string :size
      
      t.timestamps
    end
  end
end
