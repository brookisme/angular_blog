AngularBlogApp.factory "Video", ($resource) ->
  VideoResource = $resource(blog_root + "videos/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Video extends VideoResource
    