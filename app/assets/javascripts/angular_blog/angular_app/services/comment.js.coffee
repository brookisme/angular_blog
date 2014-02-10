AngularBlogApp.factory "Comment", ($resource) ->
  CommentResource = $resource(blog_root + "comments/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Comment extends CommentResource