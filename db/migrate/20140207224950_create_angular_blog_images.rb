class CreateAngularBlogImages < ActiveRecord::Migration
  def change
    create_table :angular_blog_images do |t|
      t.string :src

      t.timestamps
    end
  end
end
