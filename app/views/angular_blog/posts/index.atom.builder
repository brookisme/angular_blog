atom_feed do |feed|
  feed.title "LaborVoices Blog"
  feed.updated @posts.maximum(:updated_at)
  
  @posts.each do |post|
    if post.published?    
      feed.entry post, published: post.published_on do |entry|
        entry.title post.subject
        entry.content post.text_content
        entry.author do |author|
          unless post.blogger.nil?
            author.name post.blogger.display_name  
          end
        end
      end
    end
  end
end