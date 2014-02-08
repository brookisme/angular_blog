class CreateAngularBlogBlurbs < ActiveRecord::Migration
  def change
    create_table :angular_blog_blurbs do |t|
      t.text :content
      t.string :size
      
      t.timestamps
    end
  end
end
