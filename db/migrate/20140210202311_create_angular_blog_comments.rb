class CreateAngularBlogComments < ActiveRecord::Migration
  def change
    create_table :angular_blog_comments do |t|
      t.references :post, index: true
      t.string :email
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
