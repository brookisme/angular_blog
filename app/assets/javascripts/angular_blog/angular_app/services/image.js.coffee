AngularBlogApp.factory "Image", ($resource) ->
  ImageResource = $resource(blog_root + "images/:id", {id: "@id"}, {update: {method: "PUT"}})
  class Image extends ImageResource