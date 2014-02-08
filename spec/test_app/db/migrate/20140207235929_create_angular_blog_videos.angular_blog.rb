# This migration comes from angular_blog (originally 20140207222552)
class CreateAngularBlogVideos < ActiveRecord::Migration
  def change
    create_table :angular_blog_videos do |t|
      t.string :identifier
      t.string :host

      t.timestamps
    end
  end
end
