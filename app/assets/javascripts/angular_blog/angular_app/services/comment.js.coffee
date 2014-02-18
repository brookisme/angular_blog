AngularBlogApp.factory "Comment", ($resource) ->
  CommentResource = $resource("/blog/comments/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Comment extends CommentResource