AngularBlogApp.factory "Video", ($resource) ->
  VideoResource = $resource(blog_root + "videos/:id", {id: "@id"}, {update: {method: "PUT"}})
  class Video extends VideoResource