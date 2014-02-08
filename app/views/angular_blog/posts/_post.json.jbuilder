json.extract! post, :id, :subject, :is_sticky
json.components post.components do |json,component|
  json.partial! 'angular_blog/components/component', component: component
end
json.tags post.tags do |json,tag|
  json.partial! 'angular_blog/tags/tag', tag: tag
end