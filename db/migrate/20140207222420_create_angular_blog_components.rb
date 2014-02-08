class CreateAngularBlogComponents < ActiveRecord::Migration
  def change
    create_table :angular_blog_components do |t|
      t.references :post, index: true
      t.references :postable, polymorphic: true, index: true
      t.integer :index
      t.integer :width
      t.integer :height
      t.string :link
      t.string :css_string

      t.timestamps
    end
  end
end
