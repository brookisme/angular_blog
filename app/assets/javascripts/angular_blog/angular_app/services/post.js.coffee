AngularBlogApp.factory "Post", ($resource) ->
  PostResource = $resource("posts/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Post extends PostResource