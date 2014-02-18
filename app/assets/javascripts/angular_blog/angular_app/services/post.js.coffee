AngularBlogApp.factory "Post", ($resource) ->
  PostResource = $resource("/blog/posts/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Post extends PostResource