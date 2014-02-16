json.extract! post, :id, :subject, :is_sticky, :display_subject, :accept_comments, :comments_closed, :blogger
json.timestamp post.created_at.to_formatted_s(:long)
json.components post.components do |json,component|
  json.partial! 'angular_blog/components/component', component: component
end
json.comments post.comments do |json,comment|
  json.partial! 'angular_blog/comments/comment', comment: comment
end
json.tags post.tags do |json,tag|
  json.partial! 'angular_blog/tags/tag', tag: tag
end