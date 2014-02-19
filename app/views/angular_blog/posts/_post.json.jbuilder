json.extract! post, :id, :subject, :is_sticky, :display_subject, :accept_comments, :comments_closed, :blogger, :published
(json.timestamp post.published_on.strftime("%a, %b #{Time.now.day.ordinalize} %Y %l:%M%P")) if post.published_on
json.components post.components do |json,component|
  json.partial! 'angular_blog/components/component', component: component
end
json.comments post.comments do |json,comment|
  json.partial! 'angular_blog/comments/comment', comment: comment
end
json.tags post.tags do |json,tag|
  json.partial! 'angular_blog/tags/tag', tag: tag
end