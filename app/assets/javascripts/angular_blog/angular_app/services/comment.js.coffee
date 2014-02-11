AngularBlogApp.factory "Comment", ($resource) ->
  CommentResource = $resource("comments/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Comment extends CommentResource