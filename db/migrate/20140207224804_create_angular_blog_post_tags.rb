class CreateAngularBlogPostTags < ActiveRecord::Migration
  def change
    create_table :angular_blog_post_tags do |t|
      t.references :post, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
