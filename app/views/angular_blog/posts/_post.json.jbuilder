json.extract! post, :id, :subject, :is_sticky, :display_subject
json.timestamp post.created_at.to_formatted_s(:long)
json.author "linked author name"
json.components post.components do |json,component|
  json.partial! 'angular_blog/components/component', component: component
end
json.tags post.tags do |json,tag|
  json.partial! 'angular_blog/tags/tag', tag: tag
end