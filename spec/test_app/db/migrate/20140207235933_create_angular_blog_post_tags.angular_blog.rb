# This migration comes from angular_blog (originally 20140207224804)
class CreateAngularBlogPostTags < ActiveRecord::Migration
  def change
    create_table :angular_blog_post_tags do |t|
      t.references :post, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
