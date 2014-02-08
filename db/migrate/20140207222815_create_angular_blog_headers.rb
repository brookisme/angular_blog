class CreateAngularBlogHeaders < ActiveRecord::Migration
  def change
    create_table :angular_blog_headers do |t|
      t.string :content
      t.integer :size

      t.timestamps
    end
  end
end
