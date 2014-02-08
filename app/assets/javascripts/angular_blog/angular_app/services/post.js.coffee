AngularBlogApp.factory "Post", ($resource) ->
  PostResource = $resource(blog_root + "posts/:id", {id: "@id"}, {update: {method: "PUT"}})
  class Post extends PostResource