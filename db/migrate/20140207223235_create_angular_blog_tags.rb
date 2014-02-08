class CreateAngularBlogTags < ActiveRecord::Migration
  def change
    create_table :angular_blog_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
