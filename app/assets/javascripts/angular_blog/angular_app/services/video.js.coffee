AngularBlogApp.factory "Video", ($resource) ->
  VideoResource = $resource("/blog/videos/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Video extends VideoResource
    