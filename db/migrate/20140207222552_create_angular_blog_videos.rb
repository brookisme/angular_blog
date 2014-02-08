class CreateAngularBlogVideos < ActiveRecord::Migration
  def change
    create_table :angular_blog_videos do |t|
      t.string :identifier
      t.string :host

      t.timestamps
    end
  end
end
