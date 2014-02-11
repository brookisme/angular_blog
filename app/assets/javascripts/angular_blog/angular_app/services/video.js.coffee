AngularBlogApp.factory "Video", ($resource) ->
  VideoResource = $resource("videos/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Video extends VideoResource
    