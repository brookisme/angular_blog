# This migration comes from angular_blog (originally 20140207222815)
class CreateAngularBlogHeaders < ActiveRecord::Migration
  def change
    create_table :angular_blog_headers do |t|
      t.string :content
      t.integer :size

      t.timestamps
    end
  end
end
