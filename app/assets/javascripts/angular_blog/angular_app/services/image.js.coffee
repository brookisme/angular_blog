AngularBlogApp.factory "Image", ($resource) ->
  ImageResource = $resource("/blog/images/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Image extends ImageResource