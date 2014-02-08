class CreateAngularBlogPosts < ActiveRecord::Migration
  def change
    create_table :angular_blog_posts do |t|
      t.boolean :is_sticky
      t.string :subject

      t.timestamps
    end
  end
end
